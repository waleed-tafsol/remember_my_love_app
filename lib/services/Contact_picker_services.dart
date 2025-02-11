import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class ContactPickerService {
  // Request permissions to access contacts
  Future<bool> requestPermissions() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    if (permissionGranted) {
      return true; // Permission granted
    } else {
      if (await Permission.contacts.isPermanentlyDenied) {
        openAppSettings(); // Open settings to enable permission
      }
      return false; // Permission denied
    }
  }

  // Open device phone book to pick a contact
  Future<Contact> openDevicePhoneBook() async {
    try {
      if (await FlutterContacts.requestPermission()) {
        Contact? contact = await FlutterContacts.openExternalPick();
        if (contact != null) {
          return contact;
        } else {
          throw Exception('No contact selected');
        }
      } else {
        throw Exception('Permission denied to access contacts');
      }
    } catch (e) {
      throw Exception('Failed to open contacts: $e');
    }
  }

  // Fetch contacts with pagination (not natively supported, simulate with slicing)
  Future<List<Contact>> pickContactsPage(int startIndex, int pageSize) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withThumbnail: false,
        );
        return contacts.sublist(
          startIndex,
          (startIndex + pageSize).clamp(0, contacts.length),
        );
      } else {
        throw Exception('Permission denied to access contacts');
      }
    } catch (e) {
      throw Exception('Failed to fetch contacts: $e');
    }
  }

  // Show the bottom sheet to select a contact with a search field and pagination
  Future<void> showContactBottomSheet(
      BuildContext context, Function(Contact contact) onSelectContact) async {
    if (await requestPermissions()) {
      // Show a loading dialog while contacts are being fetched
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        const int pageSize = 20;
        int startIndex = 0;

        List<Contact> contacts = await pickContactsPage(startIndex, pageSize);
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                TextEditingController searchController =
                    TextEditingController();
                List<Contact> filteredContacts = contacts;

                void filterContacts(String query) {
                  setState(() {
                    filteredContacts = contacts
                        .where((contact) => contact.displayName
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                }

                Future<void> loadMoreContacts() async {
                  setState(() {
                    startIndex += pageSize;
                  });

                  List<Contact> newContacts =
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
                            fontSize: 18,
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
                                title: Text(contact.displayName),
                                onTap: () {
                                  onSelectContact(contact);
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
