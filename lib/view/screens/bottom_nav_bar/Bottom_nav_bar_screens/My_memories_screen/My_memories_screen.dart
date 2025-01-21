import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/VideoPlayerWidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../controllers/MyMemoriesController.dart';
import '../../../../../models/Categories.dart';
import '../../../../widgets/CachedNetworkImageWidget.dart';
import '../../../auth_screens/Splash_screen.dart';

class MyMemoriesScreen extends GetView<MyMemoryController> {
  const MyMemoriesScreen({super.key});

  void _showDropdown(BuildContext context) {
    showMenu(
      color: Colors.blue[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(50.w, 20.h, 8.w, 0.0),
      // Adjust position if needed
      items: controller.categories.map((CategoryModel value) {
        return PopupMenuItem<String>(
          onTap: () => controller.changeCatagory(value),
          value: value.name,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(10),
            child: Text(
              value.name ?? "",
              style: TextStyleConstants.bodySmallWhite(
                  context), // White text for contrast
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My Memories",
                style: TextStyleConstants.displayMediumWhite(context)),
            InkWell(
              onTap: () {
                _showDropdown(context);
              },
              child: CustomGlassButton(
                padding: EdgeInsets.all(4.w),
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  size: 3.h,
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        k1hSizedBox,
        Expanded(
          child:
              // if (controller.isLoading.value) {
              //   return Shimmer.fromColors(
              //     baseColor: AppColors.kgradientBlue,
              //     highlightColor: AppColors.kgradientPurple,
              //     child: CustomGlassmorphicContainer(
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              //       child: GridView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 3,
              //           childAspectRatio: 1,
              //           crossAxisSpacing: 8,
              //           mainAxisSpacing: 10,
              //         ),
              //         itemCount: 50,
              //         itemBuilder: (context, index) {
              //           return Container(
              //             margin: EdgeInsets.symmetric(horizontal: 1.w),
              //             width: 9.h,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   );
              // }

              CustomGlassmorphicContainer(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            controller.selectedFilter.value = "Created For You",
                        child: Obx(() {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.selectedFilter ==
                                          "Created For You"
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white.withOpacity(0.4)),
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Created For You",
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    k3wSizedBox,
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            controller.selectedFilter.value = "Created By You",
                        child: Obx(() {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.selectedFilter ==
                                          "Created By You"
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white.withOpacity(0.4)),
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Created By You",
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
                k4hSizedBox,
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final images =
                        controller.selectedFilter.value == "Created By You"
                            ? controller.by_me_images
                            : controller.for_me_images;
                    return images.isEmpty
                        ? Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(SvgAssets.search),
                                k2hSizedBox,
                                Text(
                                  "No Memory Found",
                                  style: TextStyleConstants.bodyLargeWhite(
                                      context),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () {
                              return controller.fetchMemories();
                            },
                            child: GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                final file = images[index];
                                bool isVideo = file.endsWith("mp4");
                                return InkWell(
                                  onTap: () {
                                    controller
                                        .fetchMemoryAndPassItToDetailScreen(
                                            images[index]);
                                  },
                                  child: isVideo
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: AbsorbPointer(
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                              width: 9.h,
                                              child: AbsorbPointer(
                                                child: CachedNetworkImageWidget(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "${ApiConstants.getPicture}/${images[index]}",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          );
                  }
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
