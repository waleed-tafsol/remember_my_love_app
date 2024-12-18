import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../utills/ConvertDateTime.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.id,
      required this.seen,
      required this.updatedAt});
  final String title;
  final String subTitle;
  final String id;
  final bool seen;
  final String updatedAt;

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
              title,
              style: TextStyleConstants.bodyLargeWhite(context),
            ),
            k1hSizedBox,
            Text(
              subTitle,
              style: TextStyleConstants.bodyLargeWhite(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        const Spacer(),
        Text(
          convertTimeToMinutesAgo(updatedAt),
          style: TextStyleConstants.bodySmallWhite(context),
        )
      ],
    ));
  }
}
