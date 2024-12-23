import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/VideoPlayerWidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../controllers/MyMemoriesController.dart';
import '../../../auth_screens/Splash_screen.dart';
import '../Home_screens/Memory_detail_screen.dart';

class MyMemoriesScreen extends GetView<MyMemoryController> {
  const MyMemoriesScreen({super.key});

  void _showDropdown(BuildContext context) {
    showMenu(
      color: Colors.blue[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      elevation: 0,
      context: context,
      position: RelativeRect.fromLTRB(
          50.w, 20.h, 8.w, 0.0), // Adjust position if needed
      items: controller.filters.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Container(
            color: Colors.transparent,
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
        // Handle dropdown value change
        controller.changeFilter(newValue);
      }
    });
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
          child: Obx(() {
            // If the controller is loading, show the shimmer effect
            if (controller.isLoading.value) {
              return Shimmer.fromColors(
                baseColor: AppColors.kgradientBlue,
                highlightColor: AppColors.kgradientPurple,
                child: CustomGlassmorphicContainer(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        width: 9.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return CustomGlassmorphicContainer(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: SingleChildScrollView(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.images.length,
                  itemBuilder: (context, index) {
                    final file = controller.images[index];
                    bool isVideo = file.endsWith("mp4");
                    return InkWell(
                      onTap: () {
                        controller.fetchMemoryAndPassItToDetailScreen(
                            controller.images[index]);
                      },
                      child: isVideo
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: NetworkVideoPlayerWidget(
                                  videoUrl: "${ApiConstants.getPicture}/$file",
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              width: 9.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${ApiConstants.getPicture}/${controller.images[index]}",
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Shimmer.fromColors(
                                        baseColor: AppColors.kgradientBlue,
                                        highlightColor:
                                            AppColors.kgradientPurple,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          width: 9.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
