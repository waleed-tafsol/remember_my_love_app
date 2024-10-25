import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/StyleConstants.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Upload_memory_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Notification_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/Bottom_nav_bar_controller.dart';

class BottomNavBarScreen extends GetView<BottomNavController> {
  const BottomNavBarScreen({super.key});
  static const routeName = "BottomNavBarScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBody: true,
      body: Obx(() {
        switch (controller.selectedTab.value) {
          case SelectedTab.home:
            return const HomeScreen();
          case SelectedTab.memories:
            return const MyMemoriesScreen();
          case SelectedTab.add:
            return const UploadMemoryScreen();
          case SelectedTab.profile:
            return const ProfileScreen();
          case SelectedTab.notification:
            return const NotificationScreen();
          default:
            return const HomeScreen(); // Fallback
        }
      }),
      bottomNavigationBar: Obx(() {
        return ClipRect(
          child: CrystalNavigationBar(
            marginR: EdgeInsets.symmetric(vertical: 20, horizontal: 8.w),
            itemPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 3.w),
            // margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
            currentIndex:
                SelectedTab.values.indexOf(controller.selectedTab.value),
            unselectedItemColor: Colors.white70,
            backgroundColor: Colors.black.withOpacity(0.1),
            onTap: controller.changeTab,
            items: [
              CrystalNavigationBarItem(
                icon: IconlyBold.home,
                unselectedIcon: IconlyLight.home,
                selectedColor: Colors.white,
              ),
              CrystalNavigationBarItem(
                icon: IconlyBold.heart,
                unselectedIcon: IconlyLight.heart,
                selectedColor: Colors.red,
              ),
              CrystalNavigationBarItem(
                icon: IconlyBold.plus,
                unselectedIcon: IconlyLight.plus,
                selectedColor: Colors.white,
              ),
              CrystalNavigationBarItem(
                icon: IconlyBold.notification,
                unselectedIcon: IconlyLight.notification,
                selectedColor: Colors.white,
              ),
              CrystalNavigationBarItem(
                icon: IconlyBold.user_2,
                unselectedIcon: IconlyLight.user,
                selectedColor: Colors.white,
              ),
            ],
          ),
        );
      }),
    );
  }
}
