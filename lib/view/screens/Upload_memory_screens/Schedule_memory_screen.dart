import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/constants.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import '../../widgets/Glass_text_field_with_text_widget.dart';
import '../../widgets/custom_scaffold.dart';
import '../auth_screens/sign_up_screen.dart';
import 'Memory_scheduled_succeccfully.dart';

class ScheduleMemoryScreen extends StatelessWidget {
  const ScheduleMemoryScreen({super.key});
  static const routeName = "ScheduleMemoryScreen";

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
                "Schedule Memory",
                style: TextStyleConstants.headlineLargeWhite(context),
              )
            ],
          ),
          CustomGlassmorphicContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      BottomPicker.date(
                        displayCloseIcon: true,

                        dismissable: true,
                        displaySubmitButton: true,
                        backgroundColor: AppColors.kGlassColor,
                        pickerTitle: Text(
                          '',
                          style: TextStyleConstants.bodyLargeWhite(context),
                        ),
                        buttonStyle: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        buttonWidth: 90.w,
                        buttonContent: Text(
                          "data",
                          style: TextStyleConstants.displayMediumWhite(context),
                        ),
                        // buttonContent: GradientButton(
                        //     onPressed: () {},
                        //     text: "save",
                        //     gradients: [
                        //       Colors.white,
                        //       Colors.white,
                        //     ]),
                        dateOrder: DatePickerDateOrder.mdy,
                        initialDateTime: DateTime(1996, 10, 22),
                        maxDateTime: DateTime(1998),
                        minDateTime: DateTime(1980),
                        pickerTextStyle: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        onChange: (index) {
                          print(index);
                        },
                        onSubmit: (index) {
                          print(index);
                        },
                        bottomPickerTheme: BottomPickerTheme.heavyRain,
                      ).show(context);
                    },
                    child: CustomGlassmorphicContainer(
                        borderRadius: 8,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Set Delivery Date"),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.kIconColor,
                            )
                          ],
                        )),
                  ),
                ),
                k1hSizedBox,
                const GlassTextFieldWithTitle(
                  title: 'Set Delivery Time',
                  hintText: "00 : 00",
                ),
                k1hSizedBox,
              ],
            ),
          ),
          const Spacer(),
          GradientButton(
              onPressed: () {
                Get.toNamed(MemoryScheduledSucceccfully.routeName);
              },
              text: "Send",
              gradients: [Colors.purple, Colors.blue]),
        ],
      ),
    );
  }
}
