import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/StyleConstants.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/EditProfileController.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utills/CustomSnackbar.dart';
import '../../../../widgets/gradient_button.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({super.key});
  static const routeName = "EditProfileScreen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColoredPrint.green(
        "${ApiConstants.getPicture}/${controller.homeScreenController.user.value?.photo ?? ""}");
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Profile",
                style: TextStyleConstants.displayMediumWhite(context)),
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
                                      : Image.network(
                                          controller.homeScreenController.user
                                                  .value?.photo ??
                                              "",
                                          height: 12.h,
                                          width: 12.h,
                                          fit: BoxFit.cover,
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
                        "User Name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your user name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter User Name",
                        ),
                        controller: controller.userNameController,
                      )
                    ],
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a contact";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Contact",
                        ),
                        controller: controller.contactController,
                      )
                    ],
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
                            hintStyle: TextStyle(color: Colors.white30)),
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
