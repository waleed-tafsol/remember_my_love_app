import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/constants.dart';
import '../../../controllers/Upload_memory_controller.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import '../../widgets/Glass_text_field_with_text_widget.dart';

class RecipientDetailsScreen extends GetView<UploadMemoryController> {
  const RecipientDetailsScreen({super.key});
  static const routeName = "RecipientDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  const Text(
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
                          child: const Row(
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
                  const GlassTextFieldWithTitle(
                    title: 'Enter Relation',
                    hintText: "Family, Friend, Sibling, etc",
                  ),
                  k1hSizedBox,
                  Obx(() {
                    return Column(
                      children:
                          List.generate(controller.recipients.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Text(
                                    "Recipient 0${index + 1}",
                                    style: TextStyleConstants.bodyMediumWhite(
                                            context)
                                        .copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  IconButton(
                                      color: AppColors.kGlassColor,
                                      onPressed: () {
                                        controller.removeRecipient(index);
                                      },
                                      icon: const Icon(Icons.remove))
                                ],
                              ),
                            ),
                            k1hSizedBox,
                            const GlassTextFieldWithTitle(
                              title: 'Email',
                              hintText: "Enter Email",
                            ),
                            k1hSizedBox,
                            const GlassTextFieldWithTitle(
                              title: 'Contact',
                              hintText: "Enter Phone Number",
                            )
                          ],
                        );
                      }),
                    );
                  }),
                  k1hSizedBox,
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        controller.addRecipient();
                      },
                      child: Text(
                        "Add More Recipients +",
                        style: TextStyleConstants.bodyMediumWhite(context)
                            .copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GradientButton(
                onPressed: () {
                  Get.toNamed(ScheduleMemoryScreen.routeName);
                },
                text: "Send",
                gradients: const [Colors.purple, Colors.blue]),
          ],
        ),
      ),
    );
  }
}
