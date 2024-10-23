import 'package:get/get.dart';

enum SelectedTab { home, memories, add, notification, profile }

class BottomNavController extends GetxController {
  var selectedTab = SelectedTab.home.obs;

  void changeTab(int index) {
    selectedTab.value = SelectedTab.values[index];
  }
}
