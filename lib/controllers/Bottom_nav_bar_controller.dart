import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Upload_memory_screen.dart';

enum SelectedTab { home, memories, add, notification, profile }

class BottomNavController extends GetxController {
  var selectedTab = SelectedTab.home.obs;

  void changeTab(int index) {
    index == 2
        ? Get.toNamed(UploadMemoryScreen.routeName)
        : selectedTab.value = SelectedTab.values[index];
  }
}
