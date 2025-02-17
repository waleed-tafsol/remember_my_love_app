import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/PrivacyPolicyController.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/constants.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  static const routeName = "PrivacyPolicyScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          Row(
          children: [
            CustomRoundedGlassButton(
                icon: Icons.arrow_back_ios_new,
                ontap: () {
                  Get.back();
                }),
            k2wSizedBox,
            Obx(
              () {
                return Text(controller.cmsModel.value?.heroTitle ?? "Privacy Policy",
                    style: TextStyleConstants.headlineLargeWhite(context));
              }
            ),
        
        
          ],
        ),
         Obx(
           () {
             return controller.isLoading.value ? const Center(child: const CircularProgressIndicator(),) : Html(
                                  data: controller.cmsModel.value?.description ?? "",
                                  style: {
                                    "body": Style(
                                      fontSize: FontSize.medium,
                                      color: Colors.white,
                                    ),
                                  },
                                );
           }
         )
        ],
        ),
      ),
    );
  }
}
