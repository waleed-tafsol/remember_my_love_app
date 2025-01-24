import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Calendar_controller.dart';
import 'package:remember_my_love_app/models/Categories.dart';
import 'package:remember_my_love_app/models/MemoryModel.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/VideoPlayerWidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../constants/ApiConstant.dart';
import '../../../../../../constants/TextConstant.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../models/CreatorModel.dart';
import '../../../../../../utills/ConvertDateTime.dart';
import '../../../../../widgets/CachedNetworkImageWidget.dart';
import '../../../../../widgets/Custom_glass_container.dart';

class LetterListTile extends GetView<CalendarController> {
  const LetterListTile({
    super.key,
    required this.picturesCount,
    this.id,
    this.title,
    this.status,
    this.description,
    this.catagory,
    this.createdAt,
    this.updatedAt,
    this.month,
    this.year,
    this.creator,
    this.deliveryDate,
    this.isFavorite,
    this.sendTo,
    required this.files,
    this.memory,
  });

  final String? id;
  final String? title;
  final String? status;
  final String? description;
  final CategoryModel? catagory;
  final String? createdAt;
  final String? updatedAt;
  final String? month;
  final String? year;
  final List<String>? files;
  final Creator? creator;
  final String? deliveryDate;
  final String? isFavorite;
  final String? sendTo;
  final MemoryModel? memory;

  final int picturesCount;

  @override
  Widget build(BuildContext context) {
    return CustomGlassmorphicContainer(
        width: double.infinity,
        child: InkWell(
          onTap: () {
            Get.toNamed(
              MemoryDetailScreen.routeName,
              arguments: memory,
            );
            // ColoredPrint.magenta();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? "",
                            style:
                                TextStyleConstants.headlineLargeWhite(context)
                                    .copyWith(fontWeight: FontWeight.bold),
                          ),
                          k1hSizedBox,
                          Text(
                            formatISOToCustom(
                                memory!.adjustedDeliveryDate.toString()),
                            style: TextStyleConstants.bodyMediumWhite(context),
                          )
                        ],
                      ),
                    ),
                    CustomRoundedGlassButton(icon: Icons.email, ontap: () {})
                  ],
                ),
              ),
              Obx(() {
                return controller.calendarHidden.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          k2hSizedBox,
                          const Divider(),
                          k1hSizedBox,
                          Text(
                            "Description : ${description ?? ''}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConstants.bodyMediumWhite(context),
                          ),
                          k1hSizedBox,
                          Text(
                            "Attachments :",
                            style: TextStyleConstants.bodyMediumWhite(context),
                          ),
                          k1hSizedBox,
                          files!.isEmpty
                              ? SizedBox()
                              : SizedBox(
                                  height: 9.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: files!.length >= 4
                                          ? 4
                                          : files!.length,
                                      itemBuilder: (context, index) {
                                        final file = files![index];
                                        bool isVideo = file.endsWith("mp4");
                                        if (index >= 3) {
                                          return isVideo
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: AbsorbPointer(
                                                      child: SizedBox(
                                                        height: 20.w,
                                                        width: 20.w,
                                                        child: Stack(
                                                          children: [
                                                            NetworkVideoPlayerWidget(
                                                              videoUrl:
                                                                  "${ApiConstants.getPicture}/$file",
                                                              showController:
                                                                  false,
                                                            ),
                                                            const Center(
                                                                child: Icon(Icons
                                                                    .play_circle))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 9.h,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    1.w),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImageWidget(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                files![index],
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "${(picturesCount - index).toString()} +",
                                                          style: TextStyleConstants
                                                                  .bodyLargeWhite(
                                                                      context)
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        } else {
                                          return isVideo
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: AbsorbPointer(
                                                      child: SizedBox(
                                                        height: 20.w,
                                                        width: 20.w,
                                                        child: Stack(
                                                          children: [
                                                            NetworkVideoPlayerWidget(
                                                              videoUrl:
                                                                  "${ApiConstants.getPicture}/$file",
                                                              showController:
                                                                  false,
                                                            ),
                                                            Center(child: Icon(Icons.play_circle))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: SizedBox(
                                                      width: 9.h,
                                                      child:
                                                          CachedNetworkImageWidget(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "${ApiConstants.getPicture}/${files![index]}",
                                                      ),
                                                    ),
                                                  ),
                                                );
                                        }
                                      }),
                                )
                        ],
                      )
                    : SizedBox.shrink();
              }),
            ],
          ),
        ));
  }
}

// class CustomAppBar extends AppBar {
//   final String title;
//   @override
//   // TODO: implement actions
//   List<Widget>? get actions => super.actions;
//   @override
//   IconThemeData? get actionsIconTheme {
//     return const IconThemeData(
//       color: Colors.white, // Customize the color of action icons
//       size: 24, // You can set a custom size for action icons
//     );
//   }

//   CustomAppBar({
//     Key? key,
//     required this.title,
//     Widget? leading,
//   }) : super(
//           key: key,
//           title: Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           backgroundColor: Colors.blue,
//           centerTitle: true,
//           leading: leading ?? IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.menu, color: Colors.white),
//               onPressed: () {
//                 // Handle menu action
//               },
//             ),
//           ],
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue, Colors.purple],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//         );
// }
