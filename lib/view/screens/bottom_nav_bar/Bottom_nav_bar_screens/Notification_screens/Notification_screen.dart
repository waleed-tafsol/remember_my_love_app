import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/NotificationController.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Notification_screens/Widgets/notification_listTile.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notifications",
            style: TextStyleConstants.displayMediumWhite(context)),
        k2hSizedBox,
        Expanded(
          child: Obx(() {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.notification.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NotificationListTile(
                        title: controller.notification[index].title ?? "",
                        subTitle: controller.notification[index].message ?? "",
                        id: controller.notification[index].sId ?? "",
                        updatedAt:
                            controller.notification[index].updatedAt ?? "",
                        seen: controller.notification[index].seen ?? false,
                      );
                    },
                  );
          }),
        ),
      ],
    );
  }
}
