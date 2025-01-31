import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/StyleConstants.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/EditProfileController.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/view/widgets/CachedNetworkImageWidget.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utills/CustomSnackbar.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/Glass_text_field_with_text_widget.dart';
import '../../../../widgets/gradient_button.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({super.key});
  static const routeName = "EditProfileScreen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomRoundedGlassButton(
                    icon: Icons.arrow_back_ios_new,
                    ontap: () {
                      Get.back();
                    }),
                k2wSizedBox,
                Text("Edit Profile",
                    style: TextStyleConstants.headlineLargeWhite(context)),
              ],
            ),
            k2hSizedBox,
            CustomGlassmorphicContainer(
                // height: 27.h,
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return controller.isImageUploading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.showImagePickerDialog(context);
                            },
                            child: CircleAvatar(
                              radius: 6.2.h,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Obx(() {
                                  return controller.pickedFile.value != null
                                      ? Image.file(
                                          File(controller
                                              .pickedFile.value!.path),
                                          height: 12.h,
                                          width: 12.h,
                                          fit: BoxFit.cover,
                                        )
                                      : AbsorbPointer(
                                          child: CachedNetworkImageWidget(
                                            imageUrl: controller
                                                    .homeScreenController
                                                    .user
                                                    .value
                                                    ?.photo ??
                                                "",
                                            height: 12.h,
                                            width: 12.h,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                }),
                              ),
                            ),
                          );
                  }),
                  k2hSizedBox,
                  Obx(() {
                    return controller.pickedFile.value != null
                        ? ElevatedButton(
                            style: StylesConstants
                                .elevated_b_purplebackground_whiteforeground,
                            onPressed: () {
                              controller.uploadMimeTypes();
                            },
                            child: const Text("Uplod Image"))
                        : const SizedBox();
                  }),
                  k2hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Name",
                        ),
                        controller: controller.nameController,
                      )
                    ],
                  ),
                  k2hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "UserName",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your UserName";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter User Name",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        ],
                        controller: controller.userNameController,
                      )
                    ],
                  ),
                  k1hSizedBox,
                  GlassTextFieldWithTitle(
                    title: 'Contact',
                    hintText: "Enter Contact",
                    controller: controller.contactController,
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
                    prefixWidget: CountryCodePicker(
                      onChanged: (value) {
                        controller.countryCodeController.text = value.dialCode!;
                        controller.countryController.text =
                            value.code!;
                      },
                      textStyle:
                          TextStyle(fontSize: 15.sp, color: Colors.white),
                      dialogTextStyle:
                          TextStyle(fontSize: 15.sp, color: Colors.black),
                      searchStyle:
                          TextStyle(fontSize: 15.sp, color: Colors.black),
                      searchDecoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      initialSelection: controller.countryController.value.text,
                      favorite: ['+1', 'US'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white30),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: controller
                                    .homeScreenController.user.value?.email ??
                                "",
                            hintStyle: const TextStyle(color: Colors.white30)),
                      )
                    ],
                  ),
                  k4hSizedBox,
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return GradientButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.nameController.text.isEmpty &&
                                  controller.contactController.text.isEmpty) {
                                CustomSnackbar.showError("Error",
                                    "Please enter Something in the form");
                              } else {
                                controller.upateMe();
                              }
                            }
                          },
                          text: "Update",
                          gradients: const [Colors.purple, Colors.blue]);
                    }
                  })
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
