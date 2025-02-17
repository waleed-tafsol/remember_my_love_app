import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/FingerPrintScreenController.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';

class FingerPrintScreen extends GetView<FingerPrintScreenController> {
  const FingerPrintScreen({super.key});
  static const routeName = '/finger-print-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(
        children: [
          CustomRoundedGlassButton(
              icon: Icons.arrow_back_ios_new,
              ontap: () {
                Get.back();
              }),
          k2wSizedBox,
          Text("FingerPrint",
              style: TextStyleConstants.headlineLargeWhite(context)),
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
      Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : InkWell(
                onTap: () {
                  controller.attatchFinger();
                },
                child: Center(
                  child: Icon(
                    size: 15.h,
                    Icons.fingerprint,
                    color: Colors.white,
                  ),
                ),
              );
      }),
      k2hSizedBox,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Text(
          "Please make sure you select the finger you want to use for future logins.",
          style: TextStyleConstants.bodyMediumWhite(context),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
  }
}
