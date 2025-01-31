import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/Questions_controller.dart';
import '../../../utills/string_decoration.dart';
import '../bottom_nav_bar/Bottom_nav_bar.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  static const routeName = "QuestionsScreen";

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomGlassmorphicContainer(
                    child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "We Care About You",
                                style: TextStyleConstants.displayMediumWhite(
                                    context),
                              ),
                              k1hSizedBox,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: const Text(
                                  'Have you been struggling with anything lately?',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              k2hSizedBox,
                              ...controller.concernsItems.map((answer) {
                                return InkWell(
                                  onTap: () {
                                    controller.onChanged(value: answer.sId!);
                                  },
                                  child: CustomGlassmorphicContainer(
                                    // blur: 0.0,
                                    linearGradient:
                                        controller.selectedConcern.value ==
                                                answer.sId
                                            ? const LinearGradient(colors: [
                                                Colors.white,
                                                Colors.white
                                              ])
                                            : null,
                                    borderRadius: 5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          controller.selectedConcern.value ==
                                                  answer.sId
                                              ? Icons
                                                  .radio_button_checked_outlined
                                              : Icons.circle_outlined,
                                          color: controller
                                                      .selectedConcern.value ==
                                                  answer.sId
                                              ? Colors.blue[900]
                                              : null,
                                        ),
                                        k2wSizedBox,
                                        Text(
                                          capitalizeFirstLetter(answer.name!),
                                          style: TextStyle(
                                              color: controller.selectedConcern
                                                          .value ==
                                                      answer.sId
                                                  ? Colors.blue[900]
                                                  : Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 20),
                              GradientButton(
                                onPressed: () {
                                  controller.selectedConcern.value.isNotEmpty
                                      ?
                                  controller.createConcerns().then((value){
                                    Get.toNamed(BottomNavBarScreen.routeName);
                                  }): (){};
                                },
                                cornorIconBackgroundColor:
                                    const Color.fromARGB(255, 214, 230, 253),
                                cornorIconColor: Colors.blue[900],
                                text:
                                    controller.selectedConcern.value.isNotEmpty
                                        ? "Done"
                                        : "please Select an answer",
                                textColor: Colors.blue[900],
                                gradients: const [Colors.blue, Colors.white],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                  GradientButton(
                      onPressed: () {
                        Get.toNamed(BottomNavBarScreen.routeName);
                      },
                      text: "Skip",
                      gradients: const [Colors.purple, Colors.blue])
                ],
              ),
      );
    });
  }
}
