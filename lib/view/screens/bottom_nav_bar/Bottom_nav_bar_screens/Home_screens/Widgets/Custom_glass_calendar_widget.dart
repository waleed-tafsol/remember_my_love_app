import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/Calendar_controller.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../services/Auth_services.dart';
import '../../../../../widgets/dropdown_calender.dart';

/*List<DateTime> highlightedDates = [
  DateTime.parse('2024-12-09 00:00:00.000Z'),
  DateTime.parse('2024-12-07 00:00:00.000Z'),
  DateTime.parse('2024-12-20 00:00:00.000Z'),
  DateTime.parse('2024-12-06 00:00:00.000Z')
];*/

class CustomGlassCalendarWidget extends StatelessWidget {
  CustomGlassCalendarWidget({super.key});

  final CalendarController controller = Get.put(CalendarController());
  final AuthService authService =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
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
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              textTheme: Theme.of(context).textTheme),
          child: ExpansionTile(
            expansionAnimationStyle: AnimationStyle(
                curve: Curves.easeInOut, duration: Durations.extralong1),
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
                YearMonthDropdown(),
                k1wSizedBox,
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      if (!controller.calendarHidden.value) {
                        ExpansionTileController.of(context).expand();
                        // controller.toggleCalendarVisibility(false);
                      }
                      // controller.controller.value.expand();
                    },
                    child: Obx(() {
                      return Container(
                          color: !controller.calendarHidden.value
                              ? Colors.transparent
                              : Colors.white,
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            Icons.window,
                            color: !controller.calendarHidden.value
                                ? Colors.white
                                : Colors.indigo[600],
                          ));
                    }),
                  );
                }),
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      if (controller.calendarHidden.value) {
                        ExpansionTileController.of(context).collapse();
                        // controller.toggleCalendarVisibility(true);
                      }
                    },
                    child: Obx(() {
                      return Container(
                          color: controller.calendarHidden.value
                              ? Colors.transparent
                              : Colors.white,
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            Icons.menu,
                            color: controller.calendarHidden.value
                                ? Colors.white
                                : Colors.indigo[600],
                          ));
                    }),
                  );
                }),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ))
              ],
            ),
            children: <Widget>[
              k2hSizedBox,
              Obx(() {
                return TableCalendar(
                  focusedDay: controller.focusedDay.value,
                  firstDay: controller.focusedDay.value
                      .subtract(const Duration(days: 365)),
                  lastDay: controller.focusedDay.value
                      .add(const Duration(days: 365)),
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
                  onPageChanged: (focusedDay) {
                    controller.onTabChange(focusedDay);
                  },
                  //  availableGestures: AvailableGestures.none,
                  onDaySelected: (selectedDay, focusedDay) {
                    // Handle day selection
                    print("Selected day: $selectedDay");
                    ColoredPrint.green("Focusday day: $focusedDay");
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      // Check if the current day is in the list of marked dates
                      int index = authService.memoriesDates.indexWhere((element) =>
                      element.deliveryDate!.year == date.year &&
                          element.deliveryDate!.month == date.month &&
                          element.deliveryDate!.day == date.day);
                      if (index != -1) {
                        // Return a custom widget or decoration to mark the day
                        return Positioned(
                          bottom: 25,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: authService.memoriesDates[index].status == 'due'
                                  ? Colors.red
                                  : Colors.green, // Highlight color
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null; // Return null if no marking is needed
                    },
                  ),
                );
              })
            ],
          ),
        ));
  }
}
