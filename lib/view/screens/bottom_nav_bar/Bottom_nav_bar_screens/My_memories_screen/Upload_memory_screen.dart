import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/ApiConstant.dart';
import '../../../../../controllers/Upload_memory_controller.dart';
import '../../../../widgets/CachedNetworkImageWidget.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/VideoPlayerWidget.dart';

class UploadMemoryScreen extends GetView<UploadMemoryController> {
  UploadMemoryScreen({super.key});
  static const routeName = "UploadMemoryScreen";
  bool canpop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canpop,
      onPopInvoked: (result) async {
        if (controller.successFullFilesUploads.isNotEmpty) {
          await controller.deleteFileFromAws();
        }
        // return ;
      },
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              k2hSizedBox,
              Align(
                alignment: Alignment.topLeft,
                child: CustomRoundedGlassButton(
                    icon: Icons.arrow_back_ios_new,
                    ontap: () {
                      Get.back();
                    }),
              ),
              Text(
                "Upload Memory",
                style: TextStyleConstants.displaySmallWhiteBold(context),
              ),
              // k1hSizedBox,
              // Text(
              //   "It is a long established fact that a reader will "
              //   "be distracted by the readable content"
              //   " of a page when looking at its layout.",
              //   textAlign: TextAlign.center,
              //   style: TextStyleConstants.bodyLargeWhite(context),
              // ),
              k2hSizedBox,
              CustomGlassmorphicContainer(
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                  ),
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
                            height: 3.h,
                          ),
                          Text(
                            "Select Image or Video",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.normal),
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
                  controller.showCaptureOptionDialog(context);
                },
                child: Center(
                  child: Text(
                    "Take a Photo/Video",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                ),
              )),
              Obx(() {
                return controller.reschedualMemoryFiles.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            mainAxisSpacing: 3.h,
                            crossAxisSpacing: 4.w,
                          ),
                          itemCount: controller.reschedualMemoryFiles.length,
                          itemBuilder: (context, index) {
                            final file =
                                controller.reschedualMemoryFiles[index];
                            bool isVideo = file.endsWith(".mp4");
                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: isVideo
                                          ? Stack(
                                            children: [
                                              NetworkVideoPlayerWidget(
                                                   videoUrl:
                                                      "${ApiConstants.getPicture}/$file", showController: false,
                                                ),
                                              const Center(child: Icon(Icons.play_circle))

                                            ],
                                          )
                                          : CachedNetworkImageWidget(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "${ApiConstants.getPicture}/$file",
                                            )),
                                ),
                                Positioned(
                                  right: 2.w,
                                  top: 2,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        controller.reschedualMemoryFiles
                                            .removeWhere(
                                                (file1) => file1 == file);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
              }),
              Obx(() {
                if (controller.pickedFiles.isEmpty) {
                  return const SizedBox();
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 3.h,
                    crossAxisSpacing: 4.w,
                  ),
                  itemCount: controller.pickedFiles.length,
                  itemBuilder: (context, index) {
                    final file = controller.pickedFiles[index];
                    bool isVideo = file.path.endsWith(".mp4") || file.path.endsWith(".MOV");
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: isVideo
                                ? LocalVideoPlayerWidget(
                                    filePath: file.path,
                                  )
                                : InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.file(
                                                file,
                                                fit: BoxFit.cover,
                                              ));
                                        },
                                      );
                                    },
                                    child: Image.file(
                                      file,
                                      fit: BoxFit.cover,
                                    ),
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
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
              SizedBox(
                height: 8.h,
              ),
              Obx(() {
                return controller.pickedFiles.isEmpty &&
                        controller.reschedualMemoryFiles.isEmpty
                    ? const SizedBox()
                    : GradientButton(
                        onPressed: () {
                          controller.uploadMimeTypes();
                        },
                        text: "Continue",
                        gradients: const [Colors.purple, Colors.blue]);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
