import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/controllers/UpdateUserController.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpdateUserDetails extends GetView<UpdateUserController> {
  UpdateUserDetails({super.key});
  static const routeName = 'UpdateUserDetailsScreen';

  final dynamic user_cred = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //ColoredPrint.green("${user_cred.name}");
    UpdateUserController controller = Get.find();
    return CustomScaffold(
        body: Column(
      children: [
        Row(
          children: [
            CustomRoundedGlassButton(
              icon: Icons.arrow_back_ios_new,
              ontap: () {
                Get.back();
              },
            ),
            k3wSizedBox,
            Text("Edit User",
                style: TextStyleConstants.headlineLargeWhite(context)),
          ],
        ),
        k1hSizedBox,
        CustomGlassmorphicContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 6.2.h,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Obx(() {
                  return controller.pickedFiles.value != null
                      ? Image.file(
                          File(controller.pickedFiles.value!.path),
                          height: 12.h,
                          width: 12.h,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          Image_assets.userImage,
                          height: 12.h,
                          width: 12.h,
                          fit: BoxFit.cover,
                        );
                }),
              ),
            ),

            /* CircleAvatar(
              radius: 6.2.h,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  Image_assets.userImage,
                  height: 12.h,
                  width: 12.h,
                  fit: BoxFit.cover,
                ),
              ),
            ), */
            IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    PhotoOptionsBottomSheet(UpdateUserController()),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    isScrollControlled: true,
                  );
                },
                icon: Icon(Icons.edit)),
            k1hSizedBox,
            Obx(() {
              return TextField(
                decoration: InputDecoration(
                    hintText: "Enter Name",
                    errorText: controller.nameError.value),
                onChanged: (value) {
                  controller.name_controller;
                },
                controller: controller.name_controller,
              );
            }),
            k1hSizedBox,
            Obx(() {
              return TextField(
                decoration: InputDecoration(
                    hintText: "Enter Email",
                    errorText: controller.emailError.value),
                onChanged: (value) {
                  //controller.signupValidateForm();
                },
                controller: controller.email_controller,
              );
            }),
            k1hSizedBox,
            Obx(() {
              return TextField(
                decoration: InputDecoration(
                    hintText: "Enter username",
                    errorText: controller.emailError.value),
                onChanged: (value) {
                  //controller.signupValidateForm();
                },
                controller: controller.username_controller,
              );
            }),
            k1hSizedBox,
            Obx(() {
              return TextField(
                decoration: InputDecoration(
                    hintText: "Enter Contact",
                    errorText: controller.contactError.value),
                onChanged: (value) {
                  //controller.signupValidateForm();
                },
                controller: controller.contact,
              );
            }),
          ],
        )),
        const Spacer(),
        GradientButton(
            onPressed: () {
              controller.Update_user();
            },
            text: "Update",
            gradients: const [Colors.purple, Colors.blue])
      ],
    ));
  }
}

class PhotoOptionsBottomSheet extends StatelessWidget {
  final UpdateUserController controller;
  PhotoOptionsBottomSheet(this.controller);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text("Take a Photo"),
          onTap: () {
            controller.takePhotoOrVideo();

            Get.back(); // Close the bottom sheet
            print("Take a photo tapped!");
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_library),
          title: Text("Select from Gallery"),
          onTap: () {
            controller.pickImageOrVideo();
            Get.back(); // Close the bottom sheet
            print("Select from gallery tapped!");
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
