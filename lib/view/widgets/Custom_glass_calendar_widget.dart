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

  DateTime focusedDay = DateTime.now();

  final CalendarController controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return CustomGlassmorphicContainer(
        height: 45.h,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            showTrailingIcon: false,
            title: Row(
              children: [
                Text("My Memories"),
                Spacer(),
                InkWell(
                  onTap: () {
                    _showDropdown(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getMonthName(focusedDay.month)),
                      k1wSizedBox,
                      Icon(
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
                          padding: EdgeInsets.all(3),
                          child: Icon(
                            Icons.window,
                            color: controller.calendarHidded.value
                                ? Colors.white
                                : Colors.blue[900],
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
                          padding: EdgeInsets.all(3),
                          child: Icon(
                            Icons.menu,
                            color: !controller.calendarHidded.value
                                ? Colors.white
                                : Colors.blue[900],
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
                firstDay: DateTime.now().subtract(Duration(days: 365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                headerVisible: false,
                calendarStyle: CalendarStyle(
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
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: AppColors.kPrimaryColor),
                  weekendStyle: TextStyle(color: AppColors.kPrimaryColor),
                ),
                headerStyle: HeaderStyle(),
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
      color: const Color.fromARGB(66, 255, 255, 255),
      context: context,
      position: RelativeRect.fromLTRB(
          100.0, 0.0, 0.0, 100.0), // Adjust position if needed
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      items: List.generate(12, (index) {
        String monthName = _getMonthName(index + 1);
        return PopupMenuItem<String>(
          value: monthName,
          child: CustomGlassmorphicContainer(
            borderRadius: 5,
            child: Center(
              child: Text(
                monthName,
                style: TextStyle(
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
        focusedDay = DateTime(DateTime.now().year, _getMonthIndex(newValue), 1);
        // });
      }
    });
  }

  String _getMonthName(int month) {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][month - 1];
  }

  int _getMonthIndex(String monthName) {
    return [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ].indexOf(monthName) +
        1;
  }
}
