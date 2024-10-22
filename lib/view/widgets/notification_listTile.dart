import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGlassmorphicContainer(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "William Manager",
              style: TextStyleConstants.bodyMediumWhite(context),
            ),
            k1hSizedBox,
            Text(
              "It is a long established fact that",
              style: TextStyleConstants.bodySmallWhite(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        Spacer(),
        Text(
          '2m',
          style: TextStyleConstants.bodySmallWhite(context),
        )
      ],
    ));
  }
}
