import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/Calendar_controller.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomGlassCalendarWidget extends StatelessWidget {
  CustomGlassCalendarWidget({super.key});

  final CalendarController controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 2, 255, 242).withOpacity(0.3),
              const Color.fromARGB(255, 255, 0, 238).withOpacity(0.3),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.5), // Border color
            width: 1,
          ),
        ),
        // borderRadius: 20,
        // border: 1.5,
        // blur: 10,
        // linearGradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       const Color.fromARGB(255, 2, 255, 242).withOpacity(0.3),
        //       const Color.fromARGB(255, 255, 0, 238).withOpacity(0.3),
        //     ],
        //     stops: const [
        //       0.1,
        //       1,
        //     ]),
        // borderGradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     const Color.fromARGB(255, 130, 236, 231).withOpacity(0.4),
        //     const Color.fromARGB(255, 252, 101, 242).withOpacity(0.4),
        //   ],
        // ),
        // height: 45.h,
        child: Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              textTheme: Theme.of(context).textTheme),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              controller.toggleCalendarVisibility(value);
            },
            initiallyExpanded: true,
            collapsedTextColor: AppColors.kTextWhite,
            textColor: AppColors.kTextWhite,
            showTrailingIcon: false,
            title: Row(
              children: [
                const Text(
                  "My Memories",
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _showDropdown(context);
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
                ),
                k1wSizedBox,
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      ExpansionTileController.of(context).expand();
                      controller.toggleCalendarVisibility(false);
                      // controller.controller.value.expand();
                    },
                    child: Obx(() {
                      return Container(
                          color: controller.calendarHidded.value
                              ? Colors.transparent
                              : Colors.white,
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            Icons.window,
                            color: controller.calendarHidded.value
                                ? Colors.white
                                : Colors.indigo[600],
                          ));
                    }),
                  );
                }),
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      ExpansionTileController.of(context).collapse();
                      controller.toggleCalendarVisibility(true);
                    },
                    child: Obx(() {
                      return Container(
                          color: !controller.calendarHidded.value
                              ? Colors.transparent
                              : Colors.white,
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            Icons.menu,
                            color: !controller.calendarHidded.value
                                ? Colors.white
                                : Colors.indigo[600],
                          ));
                    }),
                  );
                }),
              ],
            ),
            children: <Widget>[
              k2hSizedBox,
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                headerVisible: false,
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                rowHeight: 5.h,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: AppColors.kPrimaryColor),
                  weekendStyle: TextStyle(color: AppColors.kPrimaryColor),
                ),
                headerStyle: const HeaderStyle(),
                onDaySelected: (selectedDay, focusedDay) {
                  // Handle day selection
                  print("Selected day: $selectedDay");
                },
              ),
            ],
          ),
        ));
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      color: const Color.fromARGB(226, 66, 0, 137),
      context: context,
      position: const RelativeRect.fromLTRB(
          100.0, 0.0, 0.0, 100.0), // Adjust position if needed
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      items: List.generate(12, (index) {
        String monthName = controller.getMonthName(index + 1);
        return PopupMenuItem<String>(
          value: monthName,
          onTap: () {
            controller.focusedDay.value = DateTime(
                DateTime.now().year, controller.getMonthIndex(monthName), 1);
          },
          child: CustomGlassmorphicContainer(
            borderRadius: 5,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Center(
              child: Text(
                monthName,
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
        print("Selected Month: $newValue");
        // Update focusedDay to the first day of the selected month
        // setState(() {

        // });
      }
    });
  }
}
