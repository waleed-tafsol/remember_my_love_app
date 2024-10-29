import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../constants/TextConstant.dart';
import '../../../../../../constants/assets.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../widgets/Custom_glass_container.dart';

class LetterListTile extends StatelessWidget {
  const LetterListTile({
    super.key,
    required this.picturesCount,
  });

  final int picturesCount;

  @override
  Widget build(BuildContext context) {
    return CustomGlassmorphicContainer(
        width: double.infinity,
        child: InkWell(
          onTap: () {
            Get.toNamed(MemoryDetailScreen.routeName);
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
                        "Letter Title",
                        style: TextStyleConstants.headlineLargeWhite(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      k1hSizedBox,
                      Text(
                        "Friday, 09 July 2024 - 09:00 PM",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      )
                    ],
                  ),
                  CustomRoundedGlassButton(icon: Icons.email, ontap: () {})
                ],
              ),

              k2hSizedBox,
              Divider(),
              k2hSizedBox,
              Text(
                "Description :",
                style: TextStyleConstants.bodyMediumWhite(context),
              ),
              k1hSizedBox,
              Text(
                "It is a long established fact that a reader will be distracted by the readable"
                " content of a page when looking at its layout.",
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
              SizedBox(
                height: 9.h,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: picturesCount >= 3 ? 4 : picturesCount,
                    itemBuilder: (context, index) {
                      if (index >= 3) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          width: 9.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: const AssetImage(
                                Image_assets.userImage,
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
                            style: TextStyleConstants.bodyLargeWhite(context)
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          width: 9.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage(
                                  Image_assets.userImage,
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
