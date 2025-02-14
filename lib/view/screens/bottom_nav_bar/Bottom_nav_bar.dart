import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Notification_screens/Notification_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Home_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/My_memories_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Profile_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/Bottom_nav_bar_controller.dart';

class BottomNavBarScreen extends GetView<BottomNavController> {
  BottomNavBarScreen({super.key});
  static const routeName = "BottomNavBarScreen";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CustomScaffold(
        extendBody: true,
        body: Obx(() {
          switch (controller.selectedTab.value) {
            case SelectedTab.home:
              return HomeScreen();
            case SelectedTab.memories:
              return const MyMemoriesScreen();
            case SelectedTab.profile:
              return const ProfileScreen();
            case SelectedTab.notification:
              Future.delayed(Duration(milliseconds: 100), () {
                controller.unreadNotification.value = false;
              });
              return NotificationScreen();

            default:
              return HomeScreen(); // Fallback
          }
        }),
        bottomNavigationBar: Obx(() {
          return Stack(
            children: [
              CrystalNavigationBar(
                height: context.isTablet ? 10.h : 8.h,

                marginR: EdgeInsets.symmetric(
                    horizontal: context.isTablet ? 10.w : 50, vertical: 20),
                // itemPadding: isTablet()
                //     ? EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w)
                //     : EdgeInsets.zero,
                // margin: EdgeInsets.symmetric(horizontal: 600),
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
              Obx(() {
                return controller.unreadNotification.value
                    ? Positioned(top: 5.h, right: 30.w, child: Badge())
                    : SizedBox.shrink();
              }),
            ],
          );
        }),
      ),
    );
  }
}
