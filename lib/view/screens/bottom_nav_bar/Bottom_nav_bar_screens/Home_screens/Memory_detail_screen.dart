import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/Memory_detail_controller.dart';
import '../../../../../models/MemoryModel.dart';
import '../../../../../utills/ConvertDateTime.dart';
import '../../../../widgets/CachedNetworkImageWidget.dart';
import '../../../../widgets/VideoPlayerWidget.dart';
import '../../../network_video_player_screen.dart';
import '../My_memories_screen/Schedule_memory_screen.dart';

class MemoryDetailScreen extends StatefulWidget {
  const MemoryDetailScreen({super.key});
  static const routeName = "MemoryDetailScreen";

  @override
  State<MemoryDetailScreen> createState() => _MemoryDetailScreenState();
}

class _MemoryDetailScreenState extends State<MemoryDetailScreen> {
  HomeScreenController homeScreenController = Get.find();
  late MemoryModel memory;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      memory = Get.arguments as MemoryModel;
    }
    memoryViewed();
  }

  void memoryViewed() {
    ApiService.patchRequest(ApiConstants.memoryViewed + memory.sId!, {});
  }

  @override
  Widget build(BuildContext context) {
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
                hasDatedPassed(memory.deliveryDate)
                    ? SizedBox()
                    : Obx(() {
                        return controller.isloading.value
                            ? const SizedBox()
                            : controller.memory.creator!.sId ==
                                    homeScreenController.user.value?.sId
                                ? CustomRoundedGlassButton(
                                    icon: Icons.edit,
                                    ontap: () {
                                      hasDatedPassed(memory.deliveryDate)
                                          ? CustomSnackbar.showError(
                                              "Error", "Date has Passed")
                                          : Get.toNamed(
                                              ScheduleMemoryScreen.routeName,
                                              arguments: controller.memory);
                                    })
                                : const SizedBox();
                      }),
                SizedBox(
                  width: 2.w,
                ),
                Obx(() {
                  return controller.isloading.value
                      ? const SizedBox()
                      : controller.memory.creator!.sId ==
                              homeScreenController.user.value?.sId
                          ? CustomRoundedGlassButton(
                              icon: Icons.delete,
                              ontap: () {
                                controller.deleteMemory();
                              })
                          : const SizedBox();
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
                          bool isVideo = controller.selectedImage
                                  .endsWith("mp4") ||
                              controller.selectedImage.endsWith("quicktime");
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: isVideo
                                ? InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          NetworkVideoPlayerScreen.routeName,
                                          arguments:
                                              '${ApiConstants.getPicture}/${controller.selectedImage}');
                                      // Navigator.push(context,MaterialPageRoute(builder: (context) => NetworkVideoPlayerScreen(videoUrlData: '${ApiConstants.getPicture}/${controller.selectedImage}')) );
                                    },
                                    child: SizedBox(
                                      height: 20.h,
                                      child: Stack(
                                        children: [
                                          NetworkVideoPlayerWidget(
                                            videoUrl:
                                                "${ApiConstants.getPicture}/${controller.selectedImage}",
                                            showController: false,
                                          ),
                                          const Center(
                                              child: Icon(Icons.play_circle))
                                        ],
                                      ),
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
                          print('network file: $file');
                          bool isVideo = file.endsWith("mp4") ||
                              file.endsWith("quicktime");
                          return isVideo
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: SizedBox(
                                    width: 9.h,
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            NetworkVideoPlayerScreen.routeName,
                                            arguments:
                                                '${ApiConstants.getPicture}/$file');
                                        // Navigator.push(context,MaterialPageRoute(builder: (context) => NetworkVideoPlayerScreen(videoUrlData: '${ApiConstants.getPicture}/$file')) );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            NetworkVideoPlayerWidget(
                                              videoUrl:
                                                  "${ApiConstants.getPicture}/$file",
                                              showController: false,
                                            ),
                                            const Center(
                                                child: Icon(Icons.play_circle))
                                          ],
                                        ),
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
                          formatISOToCustomWithLocal(
                              memory.deliveryDate.toString()),
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
                                      controller.memory.recipients?[index]
                                                  ?.cc ==
                                              null
                                          ? SizedBox()
                                          : Row(
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
            /*    GradientButton(
                onPressed: () {
                  Get.toNamed(ScheduleMemoryScreen.routeName,
                      arguments: controller.memory);
                },
                text: "Reschedule Memory",
                gradients: const [Colors.purple, Colors.blue])*/
          ],
        ),
      ),
    );
  }
}
