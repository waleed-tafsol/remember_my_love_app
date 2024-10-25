import 'package:get/get.dart';

class CalendarController extends GetxController {
  RxBool calendarHidded = false.obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  void toggleCalendarVisibility(bool val) {
    calendarHidded.value != val ? calendarHidded.value = val : null;
  }

  String getMonthName(int month) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][month - 1];
  }

  int getMonthIndex(String monthName) {
    return [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ].indexOf(monthName) +
        1;
  }
}
