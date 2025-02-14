import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/models/SearchUserModel.dart';
import 'package:remember_my_love_app/services/Contact_picker_services.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/utills/Validators.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/colors_constants.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Upload_memory_controller.dart';
import '../../../../widgets/Custom_glass_container.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/Glass_text_field_with_text_widget.dart';

class RecipientDetailsScreen extends GetView<UploadMemoryController> {
  RecipientDetailsScreen({super.key});
  static const routeName = "RecipientDetailsScreen";
  final _formKey = GlobalKey<FormState>();
  Timer? _debounceTimer;
  final ContactPickerService _contactPickerService = ContactPickerService();

  Future<void> handleContactSelection(int index) async {
    try {
      bool permissionGranted =
          await ContactPickerService().requestPermissions();

      if (permissionGranted) {
        final contact = await _contactPickerService.openDevicePhoneBook();

        if (contact.phones.isNotEmpty) {
          String? phoneNumber = contact.phones.first.number;

          if (phoneNumber.startsWith('+')) {
            String countryCode = phoneNumber.split(' ')[0];
            phoneNumber = phoneNumber.replaceFirst(countryCode, '');
            phoneNumber = phoneNumber.replaceAll(' ', '');
            phoneNumber = phoneNumber.replaceAll('-', '');
            controller.recipients[index].ccp.value = countryCode;
          } else if (phoneNumber.startsWith('0')) {
            phoneNumber = phoneNumber.replaceFirst('0', '');
            phoneNumber = phoneNumber.replaceAll(' ', '');
            phoneNumber = phoneNumber.replaceAll('-', '');
            controller.recipients[index].ccp.value = "+92";
          }
          controller.recipients[index].contactController.text = phoneNumber;
        }

        if (contact.emails.isNotEmpty) {
          String? email = contact.emails.first.address;
          if (controller.recipients[index].emailController.text.isEmpty) {
            controller.recipients[index].emailController.text = email;
          } else {
            CustomSnackbar.showInfo(
                'Note', 'Clear email field to add contact email');
          }
        }

        /*if(contact.phones.isEmpty){
          controller.recipients[index].contactController.text = '';
          throw Exception(
              "No phone number available for the selected contact.");
        }*/
        /* else if(contact.emails.isEmpty){
          controller.recipients[index].emailController.text = '';
          throw Exception(
              "No email available for the selected contact.");
        }*/
      }
    } catch (e) {
      CustomSnackbar.showError("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  CustomRoundedGlassButton(
                      icon: Icons.arrow_back_ios_new, ontap: () => Get.back()),
                  k2wSizedBox,
                  Text(
                    "Recipient's Details",
                    style: TextStyleConstants.headlineLargeWhite(context),
                  )
                ],
              ),
              CustomGlassmorphicContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Send To",
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          _showDropdown(context);
                        },
                        child: CustomGlassmorphicContainer(
                            borderRadius: 8,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return Text(controller.sendTo.value);
                                }),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.kIconColor,
                                )
                              ],
                            )),
                      ),
                    ),
                    k1hSizedBox,
                    Obx(() {
                      return controller.sendTo == "self"
                          ? const SizedBox.shrink()
                          : Column(
                              children: List.generate(
                                  controller.recipients.length, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Recipient 0${index + 1}",
                                            style: TextStyleConstants
                                                    .bodyMediumWhite(context)
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          IconButton(
                                            color: AppColors.kGlassColor,
                                            onPressed: () {
                                              controller.removeRecipient(index);
                                            },
                                            icon: const Icon(Icons.remove),
                                          )
                                        ],
                                      ),
                                    ),
                                    k1hSizedBox,
                                    GlassTextFieldWithTitle(
                                      title: 'Enter Relation',
                                      hintText: "Family, Friend, Sibling, etc",
                                      controller: controller
                                          .recipients[index].relationController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                    ),
                                    k1hSizedBox,
                                    const Text("Email"),
                                    k1hSizedBox,
                                    SearchField<SearchUserModel>(
                                      searchInputDecoration:
                                          SearchInputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      handleContactSelection(
                                                          index),
                                                  icon: Icon(Icons.email))),
                                      onSearchTextChanged: (value) {
                                        if (_debounceTimer != null) {
                                          _debounceTimer?.cancel();
                                        }
                                        _debounceTimer = Timer(
                                            const Duration(milliseconds: 500),
                                            () {
                                          controller.getAvailableUsers(value);
                                        });
                                      },
                                      suggestionItemDecoration: BoxDecoration(
                                        color: AppColors.kGlassColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      itemHeight: context.isTablet ? 8.h : 6.h,
                                      suggestionsDecoration:
                                          SuggestionDecoration(
                                        color: AppColors.kGlassColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      onSuggestionTap:
                                          (SearchFieldListItem<SearchUserModel>
                                              x) {
                                        controller
                                            .recipients[index]
                                            .emailController
                                            .text = x.item?.email ?? "";
                                      },
                                      hint: "Enter Email",
                                      validator: (value) {
                                        emailValidator(value);
                                      },
                                      controller: controller
                                          .recipients[index].emailController,
                                      suggestions: controller.allAvailableUsers
                                          .map(
                                            (e) => SearchFieldListItem<
                                                SearchUserModel>(
                                              e.email ?? "",
                                              item: e,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  e.email ?? "",
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    k1hSizedBox,
                                    GlassTextFieldWithTitle(
                                      title: 'Contact',
                                      hintText: "Enter Contact",
                                      controller: controller
                                          .recipients[index].contactController,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a phone number';
                                        } else if (value.length < 10) {
                                          return 'Please enter a valid phone number with at least 10 digits';
                                        } else {
                                          return null;
                                        }
                                      },
                                      prefixWidget: Obx(() {
                                        return CountryCodePicker(
                                          onChanged: (value) {
                                            controller.recipients[index].ccp
                                                .value = value.toString();
                                            controller.recipients[index].country
                                                .value = value.code!;
                                          },
                                          textStyle: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.white,
                                          ),
                                          dialogTextStyle: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                          searchStyle: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                          searchDecoration: InputDecoration(
                                            hintText: 'Search',
                                            prefixIcon: const Icon(
                                              Icons.search,
                                              color: Colors.black,
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          initialSelection: controller
                                                      .recipients[index]
                                                      .ccp
                                                      .value ==
                                                  "+1"
                                              ? 'US' // Set 'US' as the default country when ccp is empty
                                              : controller
                                                  .recipients[index].ccp.value,
                                          favorite: ['+1', 'US'],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                        );
                                      }),
                                      suffixIcon: IconButton(
                                          onPressed: () =>
                                              handleContactSelection(index),
                                          icon: Icon(Icons.dialpad_outlined)),
                                    ),
                                  ],
                                );
                              }),
                            );
                    }),
                    k2hSizedBox,
                    Obx(() {
                      return controller.sendTo.value != "self"
                          ? Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.isapproved.value =
                                          !controller.isapproved.value;
                                    },
                                    icon: Icon(controller.isapproved.value
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank)),
                                Expanded(
                                  child: Text(
                                    "By checking this box, I confirm that I have obtained the recipient’s consent to be contacted via +18553944249.",
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    }),
                    k2hSizedBox,
                    Obx(() {
                      return controller.sendTo == "self"
                          ? const SizedBox.shrink()
                          : Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  controller.addRecipient();
                                },
                                child: Text(
                                  "Add More Recipients +",
                                  style: TextStyleConstants.bodyMediumWhite(
                                          context)
                                      .copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
              k2hSizedBox,
              GradientButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      controller.isapproved.value
                          ? Get.toNamed(ScheduleMemoryScreen.routeName)
                          : CustomSnackbar.showError(
                              "Error", "Please select the checkbox to proceed");
                    }
                  },
                  text: "Send",
                  gradients: const [Colors.purple, Colors.blue]),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      color: AppColors.kGlassColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          50.w, 20.h, 8.w, 0.0), // Adjust position if needed
      items: <String>[
        'self',
        'others',
      ].map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Container(
            color: Colors.transparent, // Semi-transparent background
            padding: const EdgeInsets.all(10),
            child: Text(
              value,
              style: TextStyleConstants.bodySmallWhite(
                  context), // White text for contrast
            ),
          ),
        );
      }).toList(),
    ).then((String? newValue) {
      if (newValue != null) {
        controller.sendTo.value = newValue;
        print(newValue);
      }
    });
  }
}
