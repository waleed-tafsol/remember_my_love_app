import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
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
import '../../../../widgets/VideoPlayerWidget.dart';
import '../../../VideoplayerScreen.dart';

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
                                    child: NetworkVideoPlayerWidget(
                                      videoUrl: controller.selectedImage.value,
                                    ),
                                  )
                                : Image.network(
                                    "${ApiConstants.getPicture}/${controller.selectedImage.value}",
                                    height: 20.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          );
                        }),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CustomRoundedGlassButton(
                            icon: Icons.more_horiz,
                            ontap: () {},
                          ),
                        )
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
                                      child: NetworkVideoPlayerWidget(
                                        videoUrl: file,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                                  width: 9.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "${ApiConstants.getPicture}/${file}",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                );
                        },
                      ),
                    ),
                    Text(
                      "Description :",
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                    k1hSizedBox,
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
                          formatISOToCustom(memory.deliveryDate.toString()),
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
                                            "Recipient 0${index + 1} :",
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
                                      k1hSizedBox,
                                      Row(
                                        children: [
                                          Text(
                                            "Email :",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                          k1wSizedBox,
                                          Text(
                                            controller.memory.recipients?[index]
                                                    ?.email ??
                                                "",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                        ],
                                      ),
                                      k1hSizedBox,
                                      Row(
                                        children: [
                                          Text(
                                            "Contact :",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
                                          k1wSizedBox,
                                          Text(
                                            controller.memory.recipients?[index]
                                                    ?.contact ??
                                                "",
                                            style: TextStyleConstants
                                                .bodyLargeWhite(context),
                                          ),
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
                onPressed: () {},
                text: "Reschedule Memory",
                gradients: const [Colors.purple, Colors.blue])
          ],
        ),
      ),
    );
  }
}

class MediaWidget extends StatefulWidget {
  final String fileUrl;
  final bool isVideo; // Flag to check if the media is a video

  const MediaWidget({Key? key, required this.fileUrl, required this.isVideo})
      : super(key: key);

  @override
  _MediaWidgetState createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isVideo) {
          Get.toNamed(VideoPlayerScreen.routeName, arguments: widget.fileUrl);
        }
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: widget.isVideo
              ? DecorationImage(
                  image: NetworkImage(widget.fileUrl),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: widget.isVideo
            ? const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
