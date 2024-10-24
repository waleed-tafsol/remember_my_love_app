import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/constants.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import '../../widgets/Glass_text_field_with_text_widget.dart';
import '../auth_screens/sign_up_screen.dart';

class RecipientDetailsScreen extends StatelessWidget {
  const RecipientDetailsScreen({super.key});
  static const routeName = "RecipientDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            children: [
              CustomRoundedGlassButton(
                  icon: Icons.arrow_back_ios_new, ontap: () => Get.back()),
              k2wSizedBox,
              Text(
                "Write a Memory",
                style: TextStyleConstants.headlineLargeWhite(context),
              )
            ],
          ),
          CustomGlassmorphicContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send To",
                ),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {},
                    child: CustomGlassmorphicContainer(
                        borderRadius: 8,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Others"),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.kIconColor,
                            )
                          ],
                        )),
                  ),
                ),
                GlassTextFieldWithTitle(
                  title: 'Enter Relation',
                  hintText: "Family, Friend, Sibling, etc",
                ),
                k1hSizedBox,
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "Recipient 01",
                        style: TextStyleConstants.bodyMediumWhite(context)
                            .copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      IconButton(
                          color: AppColors.kGlassColor,
                          onPressed: () {},
                          icon: Icon(Icons.remove))
                    ],
                  ),
                ),
                k1hSizedBox,
                GlassTextFieldWithTitle(
                  title: 'Email',
                  hintText: "Enter Email",
                ),
                k1hSizedBox,
                GlassTextFieldWithTitle(
                  title: 'Contact',
                  hintText: "Enter Phone Number",
                ),
                k1hSizedBox,
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Add More Recipients +",
                      style:
                          TextStyleConstants.bodyMediumWhite(context).copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          GradientButton(
              onPressed: () {
                Get.toNamed(ScheduleMemoryScreen.routeName);
              },
              text: "Send",
              gradients: [Colors.purple, Colors.blue]),
        ],
      ),
    );
  }
}
