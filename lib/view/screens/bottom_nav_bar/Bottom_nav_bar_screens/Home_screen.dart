import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constants/assets.dart';
import '../../../widgets/Letter_list_tile_widget.dart';
import '../../../widgets/My_storage_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final picturesCount = 20;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        CustomGlassmorphicContainer(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                      child: Image.asset(
                    Image_assets.userImage,
                    height: 10.h,
                    width: 10.h,
                    fit: BoxFit.cover,
                  )),
                  k2wSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                      Text(
                        "Michael Jones",
                        style:
                            TextStyleConstants.displayMediumWhiteBold(context),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const My_storage_widget(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return LetterListTile(picturesCount: picturesCount);
            })
      ]),
    );
  }
}
