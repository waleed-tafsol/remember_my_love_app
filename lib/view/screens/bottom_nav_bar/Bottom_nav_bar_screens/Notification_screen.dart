import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/notification_listTile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notifications",
            style: TextStyleConstants.headlineLargeWhite(context)),
        k2hSizedBox,
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const NotificationListTile();
            },
          ),
        ),
      ],
    );
  }
}
