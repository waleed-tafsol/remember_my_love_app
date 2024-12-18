import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/models/Categories.dart';
import 'package:remember_my_love_app/models/MemoryModel.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../constants/TextConstant.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../models/CreatorModel.dart';
import '../../../../../../utills/ConvertDateTime.dart';
import '../../../../../widgets/Custom_glass_container.dart';

class LetterListTile extends StatelessWidget {
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

  // final int picturesCount;
  final String? id;
  final String? title;
  final String? status;
  final String? description;
  final Category? catagory;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: TextStyleConstants.headlineLargeWhite(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      k1hSizedBox,
                      Text(
                        formatISOToCustom(memory!.createdAt.toString()),
                        style: TextStyleConstants.bodyMediumWhite(context),
                      )
                    ],
                  ),
                  CustomRoundedGlassButton(icon: Icons.email, ontap: () {})
                ],
              ),

              k2hSizedBox,
              const Divider(),
              k2hSizedBox,
              Text(
                "Description :",
                style: TextStyleConstants.bodyMediumWhite(context),
              ),
              k1hSizedBox,
              Text(
                description ?? '',
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
              // List.generate(5, Container())
              files!.isEmpty
                  ? SizedBox()
                  : SizedBox(
                      height: 9.h,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: files!.length >= 3 ? 4 : files!.length,
                          itemBuilder: (context, index) {
                            if (index >= 3) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.w),
                                width: 9.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${ApiConstants.getPicture}/${files![index]}",
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  "${(picturesCount - index).toString()} +",
                                  style:
                                      TextStyleConstants.bodyLargeWhite(context)
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                )),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.w),
                                width: 9.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "${ApiConstants.getPicture}/${files![index]}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              );
                            }
                          }),
                    )
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
