import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  RxBool calendarHidded = false.obs;

  void toggleCalendarVisibility(bool val) {
    calendarHidded.value != val ? calendarHidded.value = val : null;
  }
}
