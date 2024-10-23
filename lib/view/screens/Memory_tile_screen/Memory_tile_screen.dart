import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/constants.dart';

class MemoryTileScreen extends StatelessWidget {
  const MemoryTileScreen({super.key});
  static const routeName = "MemoryTileScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
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
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description :",
                style: TextStyleConstants.bodyLargeWhite(context),
              ),
              k1hSizedBox,
              Text(
                "It is a long established fact that a reader will be distracted by the readable"
                " content of a page when looking at its layout. "
                "It is a long established fact that a reader will be"
                " distracted by the readable content of a page when looking at its layout.",
                style: TextStyleConstants.bodyMediumWhite(context),
              ),
              k1hSizedBox,
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: AppColors.kIconColor,
                  ),
                  k1wSizedBox,
                  Text(
                    "Scheduled On",
                    style: TextStyleConstants.bodySmallWhite(context),
                  ),
                  Spacer(),
                  Text(
                    "Friday, 09 July 2024 - 09:00 PM",
                    style: TextStyleConstants.bodySmallWhite(context),
                  ),
                ],
              ),
              k1hSizedBox,
              Text(
                "Recipient 01 :",
                style: TextStyleConstants.bodyLargeWhite(context),
              ),
              k1hSizedBox,
              Row(
                children: [
                  Text(
                    "Email :",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                  k1wSizedBox,
                  Text(
                    "johndoe@gmail.com",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                ],
              ),
              k1hSizedBox,
              Row(
                children: [
                  Text(
                    "Contact :",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                  k1wSizedBox,
                  Text(
                    "+ 454 5412 3548",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                ],
              ),
              k1hSizedBox,
              Text(
                "Recipient 02 :",
                style: TextStyleConstants.bodyLargeWhite(context),
              ),
              k1hSizedBox,
              Row(
                children: [
                  Text(
                    "Email :",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                  k1wSizedBox,
                  Text(
                    "johndoe@gmail.com",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                ],
              ),
              k1hSizedBox,
              Row(
                children: [
                  Text(
                    "Contact :",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                  k1wSizedBox,
                  Text(
                    "+ 454 5412 3548",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  ),
                ],
              ),
            ],
          )),
          GradientButton(
              onPressed: () {},
              text: "Reschedule Memory",
              gradients: [Colors.purple, Colors.blue])
        ],
      ),
    );
  }
}
