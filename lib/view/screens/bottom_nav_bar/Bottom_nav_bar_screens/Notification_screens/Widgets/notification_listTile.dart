import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Choose_Your_plan_Screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../controllers/NotificationController.dart';
import '../../../../../../models/NotificationModel.dart';
import '../../../../../../utills/ConvertDateTime.dart';

class NotificationListTile extends GetView<NotificationController> {
  const NotificationListTile({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (notification.flag == "memory") {
          controller.fetchMemoryAndPassItToDetailScreen(
              notification.payload?[0].id ?? "");
        } else if (notification.flag == "subscription") {
          Get.toNamed(ChooseYourPlanScreen.routeName);
        } else {
          null;
        }
      },
      child: CustomGlassmorphicContainer(
          child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              Image_assets.userImage,
              height: 6.h,
              width: 6.h,
              fit: BoxFit.cover,
            ),
          ),
          k3wSizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? "",
                  style: TextStyleConstants.bodyLargeWhite(context),
                ),
                k1hSizedBox,
                Expanded(
                  child: Text(
                    notification.message ?? "",
                    style: TextStyleConstants.bodyLargeWhite(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          // const Spacer(),
          Text(
            convertTimeToMinutesAgo(notification.createdAt ?? ""),
            style: TextStyleConstants.bodySmallWhite(context),
          )
        ],
      )),
    );
  }
}
