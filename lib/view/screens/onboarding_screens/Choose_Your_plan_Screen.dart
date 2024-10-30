import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Continue_screen.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Questions_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/Custom_glass_container.dart';

class ChooseYourPlanScreen extends StatefulWidget {
  const ChooseYourPlanScreen({super.key});
  static const routeName = "ChooseYourPlanScreen";

  @override
  State<ChooseYourPlanScreen> createState() => _ChooseYourPlanScreenState();
}

class _ChooseYourPlanScreenState extends State<ChooseYourPlanScreen> {
  bool _monthlySelected = true;

  void changeType() {
    setState(() {
      _monthlySelected = !_monthlySelected;
    });
  }

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
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.kPrimaryColor, width: 2)),
            height: kButtonHeight,
            width: 60.w,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _monthlySelected ? null : changeType();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: _monthlySelected
                              ? AppColors.kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0)),
                      alignment: Alignment.center,
                      child: Text(
                        "Monthly",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: _monthlySelected
                                ? AppColors.kSecondaryColor
                                : AppColors.kTextWhite),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      !_monthlySelected ? null : changeType();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _monthlySelected
                            ? Colors.transparent
                            : AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Yearly",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: !_monthlySelected
                                ? AppColors.kSecondaryColor
                                : AppColors.kPrimaryColor),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$39.99",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _monthlySelected ? "/month" : "/Year",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.kIconColor,
                      ),
                      k1wSizedBox,
                      Text(
                        "Get 1 TB Storage",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          GradientButton(
              onPressed: () {
                Get.offAllNamed(
                  ContinueScreen.routeName,
                  arguments: {
                    "title": "Grateful for Every Moment",
                    "subtitle": "We're excited to share that your picture will be the cover of a special"
                        "collection of cherished memories and videos, which will be delivered"
                        "to your loved ones at a time you choose, allowing you to share those precious moments with them.",
                    "callback": () => Get.toNamed(QuestionsScreen.routeName)
                  },
                );
              },
              text: "Select This Plan",
              gradients: const [Colors.purpleAccent, Colors.blue]),
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
