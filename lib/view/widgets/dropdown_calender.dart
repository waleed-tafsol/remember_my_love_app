import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/Calendar_controller.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors_constants.dart';

class YearMonthDropdown extends GetWidget<CalendarController> {
  const YearMonthDropdown({super.key});

  Widget buildYearMonthPopup(BuildContext context) {
    return CustomGlassmorphicContainer(
      // width: 80.w,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_left,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: controller.incrementYear,
              ),
              InkWell(
                onTap: () {
                  _showDropdown(context);
                },
                child: Obx(() {
                  return Text(
                    "${controller.focusedDay.value.year} "
                    "${controller.getMonthName(controller.focusedDay.value.month)}",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  );
                }),
              ),
              // DropdownButton<int>(
              //   value: selectedYear,
              //   items: years.map((year) {
              //     return DropdownMenuItem<int>(
              //       value: year,
              //       child: Text(year.toString()),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       selectedYear = value!;
              //       currentYearIndex = years.indexOf(selectedYear);
              //     });
              //   },
              // ),
              IconButton(
                icon: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: controller.decrementYear,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: 1.w,
            children: controller.months.map((month) {
              return GestureDetector(
                onTap: () {
                  controller.changeMonth(month);
                  Get.back();
                },
                child: CustomGlassmorphicContainer(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  width: 20.w,
                  child: Center(
                    child: Text(
                      month,
                      style: TextStyleConstants.bodyLargeWhite(context),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      color: const Color.fromARGB(226, 66, 0, 137),
      context: context,
      position: const RelativeRect.fromLTRB(100.0, 0.0, 0.0, 100.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      items: controller.years.map((year) {
        return PopupMenuItem<String>(
          value: year.toString(),
          onTap: () {
            controller.changeYear(year);
          },
          child: CustomGlassmorphicContainer(
            borderRadius: 5,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Center(
              child: Text(
                year.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.kTextWhite), // Customize text style
              ),
            ),
          ),
        );
      }).toList(),
    ).then((String? newValue) {
      if (newValue != null) {
        // Handle dropdown value change
        print("Selected year: $newValue");
        // Update focusedDay to the first day of the selected month
        // setState(() {

        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(enabled: false, child: buildYearMonthPopup(context)),
        ];
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return Text(
              "${controller.focusedDay.value.year} "
              "${controller.getMonthName(controller.focusedDay.value.month)}",
            );
          }),
          k1wSizedBox,
          const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: AppColors.kIconColor,
          )
        ],
      ),
    );
  }
}
