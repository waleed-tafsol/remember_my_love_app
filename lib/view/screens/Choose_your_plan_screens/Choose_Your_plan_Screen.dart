import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/Choose_your_plan_screens/Continue_screen.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/onboarding_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/Custom_glass_container.dart';

class ChooseYourPlanScreen extends StatelessWidget {
  const ChooseYourPlanScreen({super.key});
  static const routeName = "ChooseYourPlanScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Text(
            "Choose Your Plan",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          k1hSizedBox,
          Text(
            "Choose a Plan to Avail Special Features",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          k4hSizedBox,
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.kPrimaryColor, width: 2)),
            height: kButtonHeight,
            width: 60.w,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0)),
                    alignment: Alignment.center,
                    child: Text(
                      "Monthly",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.kTextWhite),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Yearly",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.kSecondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomGlassmorphicContainer(
            width: double.infinity,
            height: 20.h,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "\$39.99",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "/Year",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.kIconColor,
                      ),
                      k1wSizedBox,
                      Text(
                        "Get 1 TB Storage",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          GradientButton(
              onPressed: () {
                Get.toNamed(ContinueScreen.routeName);
              },
              text: "Select This Plan",
              gradients: [Colors.purpleAccent, Colors.blue]),
          k2hSizedBox,
          Text(
            "Stick with 1 GB Free Plan",
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
