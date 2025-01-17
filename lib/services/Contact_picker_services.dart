import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactPickerService {
  // Request permissions to access contacts
  Future<bool> requestPermissions() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      return true; // Permission granted
    } else if (status.isDenied) {
      return false; // Permission denied
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Open settings to enable permission
      return false;
    }
    return false;
  }

  Future<Contact> openDevicePhoneBook() async {
    try {
      Contact? contact = await ContactsService.openDeviceContactPicker();

      return contact != null ? contact : throw Exception('No contact selected');
    } catch (e) {
      throw Exception('No contact selected: $e');
    }
  }

  // Fetch a page of contacts with pagination
  Future<List<Contact?>> pickContactsPage(int startIndex, int pageSize) async {
    try {
      // Fetch contacts starting from the startIndex, limited by pageSize
      Iterable<Contact> contacts = await ContactsService.getContacts(
        withThumbnails: false,
        // pageSize: pageSize,
        // offset: startIndex,
      );
      if (contacts.isNotEmpty) {
        return contacts.toList();
      }
    } catch (e) {
      throw Exception('Failed to fetch contacts: $e');
    }
    return [];
  }

  // Show the bottom sheet to select a contact with a search field and pagination
  Future<void> showContactBottomSheet(
      BuildContext context, Function(Contact contact) onSelectContact) async {
    if (await requestPermissions()) {
      // Show a loading dialog while contacts are being fetched
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        const int pageSize = 20;
        int startIndex = 0;

        List<Contact?> contacts = await pickContactsPage(startIndex, pageSize);
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                TextEditingController searchController =
                    TextEditingController();
                List<Contact?> filteredContacts = contacts;

                void filterContacts(String query) {
                  setState(() {
                    filteredContacts = contacts
                        .where((contact) =>
                            contact?.displayName
                                ?.toLowerCase()
                                .contains(query.toLowerCase()) ??
                            false)
                        .toList();
                  });
                }

                Future<void> loadMoreContacts() async {
                  setState(() {
                    startIndex += pageSize;
                  });

                  List<Contact?> newContacts =
                      await pickContactsPage(startIndex, pageSize);
                  setState(() {
                    contacts.addAll(newContacts);
                    filteredContacts = contacts;
                  });
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search Contacts',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (query) {
                          filterContacts(query);
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Select a contact:',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredContacts.length + 1,
                          itemBuilder: (context, index) {
                            if (index < filteredContacts.length) {
                              final contact = filteredContacts[index];
                              return ListTile(
                                title: Text(contact?.displayName ??
                                    'No name available'),
                                onTap: () {
                                  onSelectContact(contact!);
                                  Navigator.pop(context);
                                },
                              );
                            } else {
                              return Center(
                                child: ElevatedButton(
                                  onPressed: loadMoreContacts,
                                  child: Text('Load More'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading contacts: $e')),
        );
      }
    }
  }
}
