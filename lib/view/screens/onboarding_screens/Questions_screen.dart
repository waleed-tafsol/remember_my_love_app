import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/Questions_controller.dart';
import '../bottom_nav_bar/Bottom_nav_bar.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  static const routeName = "QuestionsScreen";

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomGlassmorphicContainer(
            child: Obx(() {
              final currentQuestion =
                  controller.questions[controller.currentQuestionIndex.value];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "We Care About You",
                        style: TextStyleConstants.displayMediumWhite(context),
                      ),
                      k1hSizedBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          controller
                              .questions[controller.currentQuestionIndex.value]
                              .question,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      k2hSizedBox,
                      ...currentQuestion.answers.map((answer) {
                        return InkWell(
                          onTap: () {
                            controller.onChanged(answer);
                          },
                          child: CustomGlassmorphicContainer(
                            // blur: 0.0,
                            linearGradient:
                                currentQuestion.selectedAnswer.value == answer
                                    ? const LinearGradient(
                                        colors: [Colors.white, Colors.white])
                                    : null,
                            borderRadius: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  currentQuestion.selectedAnswer.value == answer
                                      ? Icons.radio_button_checked_outlined
                                      : Icons.circle_outlined,
                                  color: currentQuestion.selectedAnswer.value ==
                                          answer
                                      ? Colors.blue[900]
                                      : null,
                                ),
                                k2wSizedBox,
                                Text(
                                  answer,
                                  style: TextStyle(
                                      color: currentQuestion
                                                  .selectedAnswer.value ==
                                              answer
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
                          currentQuestion.selectedAnswer.value != null
                              ? controller.nextQuestion()
                              : null;
                        },
                        cornorIconBackgroundColor:
                            const Color.fromARGB(255, 214, 230, 253),
                        cornorIconColor: Colors.blue[900],
                        text: currentQuestion.selectedAnswer.value != null
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
  }
}
