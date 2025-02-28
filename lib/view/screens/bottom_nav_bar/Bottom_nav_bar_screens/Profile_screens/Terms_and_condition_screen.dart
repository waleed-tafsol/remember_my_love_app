import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/TermsAndConditionsController.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/constants.dart';
import '../../../../widgets/Custom_rounded_glass_button.dart';
import '../../../../widgets/custom_scaffold.dart';
import 'package:flutter_html/flutter_html.dart';


class TermsAndConditionScreen extends GetView<TermsAndConditionsController> {
  const TermsAndConditionScreen({super.key});

  static const routeName = "TermsAndConditionScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: 
    SingleChildScrollView(
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
                return Text(controller.cmsModel.value?.heroTitle ?? "Terms And Conditions",
                    style: TextStyleConstants.headlineLargeWhite(context));
              }
            ),
        
        
          ],
        ),
         Obx(
           () {
             return controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) : Html(
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



