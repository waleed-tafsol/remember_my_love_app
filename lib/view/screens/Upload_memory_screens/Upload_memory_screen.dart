import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Write_a_memory.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/Upload_memory_controller.dart';

class UploadMemoryScreen extends GetView<UploadMemoryController> {
  const UploadMemoryScreen({super.key});
  static const routeName = "UploadMemoryScreen";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Upload Memory",
                  style: TextStyleConstants.displaySmallWhiteBold(context),
                ),
                Text(
                  "It is a long established fact that a reader will "
                  "be distracted by the readable content"
                  " of a page when looking at its layout.",
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.bodyLargeWhite(context),
                ),
                CustomGlassmorphicContainer(
                    child: InkWell(
                  onTap: () {
                    controller.pickImageOrVideo();
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 8.h,
                          Icons.image_outlined,
                          color: AppColors.kIconColor,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Select Image or Video",
                          style: TextStyleConstants.bodyLargeWhite(context),
                        )
                      ],
                    ),
                  ),
                )),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    k1wSizedBox,
                    const Text("Or"),
                    k1wSizedBox,
                    const Expanded(child: Divider())
                  ],
                ),
                CustomGlassmorphicContainer(
                    child: InkWell(
                  onTap: () {
                    controller.takePhotoOrVideo();
                  },
                  child: Center(
                    child: Text(
                      "Take a Photo/Video",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ),
                )),
                // GridView to display selected images
                Obx(() {
                  if (controller.pickedFiles.isEmpty) {
                    return const SizedBox();
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        childAspectRatio: 1.1, // Aspect ratio of grid items
                        mainAxisSpacing: 3.h,
                        crossAxisSpacing: 4.w),
                    itemCount: controller.pickedFiles.length,
                    itemBuilder: (context, index) {
                      final file = controller.pickedFiles[index];
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 2.w,
                              top: 2,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      controller.removeFile(file);
                                    }),
                              ))
                        ],
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Obx(() {
            return controller.pickedFiles.isEmpty
                ? const SizedBox()
                : GradientButton(
                    onPressed: () {
                      Get.toNamed(WriteAMemoryScreen.routeName);
                    },
                    text: "Continue",
                    gradients: const [Colors.purple, Colors.blue]);
          }),
        ),
      ],
    );
  }
}
