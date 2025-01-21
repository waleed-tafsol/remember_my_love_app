import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Upload_memory_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Memory_detail_controller.dart';
import '../../../../../models/MemoryModel.dart';
import '../../../../../utills/ConvertDateTime.dart';
import '../../../../widgets/CachedNetworkImageWidget.dart';
import '../../../../widgets/VideoPlayerWidget.dart';

class MemoryDetailScreen extends StatelessWidget {
  MemoryDetailScreen({super.key});

  static const routeName = "MemoryDetailScreen";

  @override
  Widget build(BuildContext context) {
    final MemoryModel memory = Get.arguments as MemoryModel;

    // Initialize the controller with the passed memory
    final MemoryDetailController controller =
        Get.put(MemoryDetailController(memory));
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomRoundedGlassButton(
                    icon: Icons.arrow_back_ios_new,
                    ontap: () {
                      Get.back();
                    }),
                k2wSizedBox,
                Text("My Memories",
                    style: TextStyleConstants.headlineLargeWhite(context)),
                const Spacer(),
                Obx(() {
                  return controller.isloading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomRoundedGlassButton(
                          icon: Icons.delete,
                          ontap: () {
                            controller.deleteMemory();
                          });
                }),
              ],
            ),
            CustomGlassmorphicContainer(
                height: null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Obx(() {
                          bool isVideo =
                              controller.selectedImage.endsWith("mp4");
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: isVideo
                                ? SizedBox(
                                    height: 20.h,
                                    child: Stack(
                                      children: [
                                        NetworkVideoPlayerWidget(
                                          videoUrl:
                                              "${ApiConstants.getPicture}/${controller.selectedImage}",
                                          showController: false,
                                        ),
                                        Center(child: Icon(Icons.play_circle))
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    height: 20.h,
                                    child: CachedNetworkImageWidget(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "${ApiConstants.getPicture}/${controller.selectedImage.value}",
                                    ),
                                  ),
                          );
                        }),
                        // Positioned(
                        //   top: 0,
                        //   right: 0,
                        //   child: CustomRoundedGlassButton(
                        //     icon: Icons.more_horiz,
                        //     ontap: () {},
                        //   ),
                        // )
                      ],
                    ),
                    k1hSizedBox,
                    SizedBox(
                      height: 10.h,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.memory.files!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final file = controller.memory.files![index];
                          bool isVideo = file.endsWith("mp4");
                          return isVideo
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: SizedBox(
                                    width: 9.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          NetworkVideoPlayerWidget(
                                            videoUrl:
                                                "${ApiConstants.getPicture}/$file",
                                            showController: false,
                                          ),
                                          Center(child: Icon(Icons.play_circle))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: 9.h,
                                      child: CachedNetworkImageWidget(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "${ApiConstants.getPicture}/$file",
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    k1hSizedBox,
                    Text(
                      "Description : ",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                    Text(
                      controller.memory.description ?? "",
                      style: TextStyleConstants.bodyMediumWhite(context),
                    ),
                    k1hSizedBox,
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: AppColors.kIconColor,
                        ),
                        k2wSizedBox,
                        Text(
                          "Scheduled On",
                          style: TextStyleConstants.bodySmallWhite(context),
                        ),
                        const Spacer(),
                        Text(
                          formatISOToCustom(
                              memory.adjustedDeliveryDate.toString()),
                          style: TextStyleConstants.bodySmallWhite(context),
                        ),
                      ],
                    ),
                    k1hSizedBox,
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: AppColors.kIconColor,
                        ),
                        k2wSizedBox,
                        Text(
                          "Created On",
                          style: TextStyleConstants.bodySmallWhite(context),
                        ),
                        const Spacer(),
                        Text(
                          formatISOToCustomWithLocal(
                              memory.createdAt.toString()),
                          style: TextStyleConstants.bodySmallWhite(context),
                        ),
                      ],
                    ),
                    k1hSizedBox,
                    controller.memory.recipients == null
                        ? const SizedBox()
                        : SizedBox(
                            height: 25.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.memory.recipients?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Recipient 0${index + 1} : ",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                          Text(
                                            controller.memory.recipients?[index]
                                                    ?.relation ??
                                                "",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                        ],
                                      ),
                                      k05hSizedBox,
                                      Row(
                                        children: [
                                          Text(
                                            "Email : ",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                          k05hSizedBox,
                                          Text(
                                            controller.memory.recipients?[index]
                                                    ?.email ??
                                                "",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                        ],
                                      ),
                                      k05hSizedBox,
                                      Row(
                                        children: [
                                          Text(
                                            "Contact : ",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                          k1wSizedBox,
                                          Text(
                                            "${controller.memory.recipients?[index]?.cc ?? ""}${controller.memory.recipients?[index]?.contact ?? ""}",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          )
                                        ],
                                      ),
                                      // k1hSizedBox,
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "User Name :",
                                      //       style: TextStyleConstants.bodyLargeWhite(
                                      //           context),
                                      //     ),
                                      //     k1wSizedBox,
                                      //     Text(
                                      //       controller.memory.recipients?[index].
                                      //                ??
                                      //           "",
                                      //       style: TextStyleConstants.bodyLargeWhite(
                                      //           context),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  );
                                }),
                          ),
                  ],
                )),
            GradientButton(
                onPressed: () {
                  Get.toNamed(UploadMemoryScreen.routeName,
                      arguments: controller.memory);
                },
                text: "Reschedule Memory",
                gradients: const [Colors.purple, Colors.blue])
          ],
        ),
      ),
    );
  }
}
