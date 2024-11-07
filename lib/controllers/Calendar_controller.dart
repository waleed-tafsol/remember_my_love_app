import 'package:get/get.dart';

class CalendarController extends GetxController {
  @override
  void onInit() {
    focusedDay = DateTime.now().obs;
    years = List.generate(20, (index) => focusedDay.value.year + index);
    super.onInit();
  }

  RxBool calendarHidden = false.obs;
  late Rx<DateTime> focusedDay;

  late List<int> years;

  final List<String> months = [
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
    'Dec'
  ];

  void toggleCalendarVisibility(bool val) {
    calendarHidden.value != val ? calendarHidden.value = val : null;
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

  void decrementYear() {
    focusedDay.value =
        DateTime(focusedDay.value.year - 1, focusedDay.value.month, 1);
  }

  void incrementYear() {
    focusedDay.value =
        DateTime(focusedDay.value.year + 1, focusedDay.value.month, 1);
  }

  void changeYear(int year) {
    focusedDay.value = DateTime(year, focusedDay.value.month, 1);
  }

  void changeMonth(String month) {
    focusedDay.value = DateTime(focusedDay.value.year, getMonthIndex(month), 1);
  }
}
