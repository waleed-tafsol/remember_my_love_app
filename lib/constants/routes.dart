import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/Choose_your_plan_screens/Choose_Your_plan_Screen.dart';
import 'package:remember_my_love_app/view/screens/Choose_your_plan_screens/Continue_screen.dart';
import 'package:remember_my_love_app/view/screens/Privacy_policy_screens/Privacy_policy_screen.dart';
import 'package:remember_my_love_app/view/screens/Terms_and_conditions_screen/Terms_and_condition_screen.dart';
import 'package:remember_my_love_app/view/screens/update_password_screen/update_password_screen.dart';
import 'package:remember_my_love_app/view/screens/upgrade_plan_screen.dart/upgrade_plan_screen.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/screens/Upload_memory_screens/Write_a_memory.dart';
import '../bindings/Bottom_nav_bar_bindings.dart';
import '../bindings/Memory_detail_bindings.dart';
import '../bindings/Questions_bindings.dart';
import '../bindings/UpgradePlanBindings.dart';
import '../bindings/splash_binding.dart';
import '../view/screens/Memory_tile_screen/Memory_tile_screen.dart';
import '../view/screens/Questions_screens/Questions_screen.dart';
import '../view/screens/Upload_memory_screens/Memory_scheduled_succeccfully.dart';
import '../view/screens/Upload_memory_screens/Recipient_details_screen.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../view/screens/auth_screens/sign_up_screen.dart';
import '../view/screens/onboarding_screens/onboarding_screen.dart';
import '../view/screens/splash_screens/Splah_screen.dart';

class Pages {
  static Transition get _routeTransition => Transition.fade;
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const SplashScreen(),
          binding: SplashBinding(),
          transition: _routeTransition,
        );
      case SignUpScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const SignUpScreen(),
          // binding: SplashBinding(),
          transition: _routeTransition,
        );
      case OnboardingScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const OnboardingScreen(),
          // binding: SplashBinding(),
          transition: _routeTransition,
        );
      case ChooseYourPlanScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const ChooseYourPlanScreen(),
          // binding: SplashBinding(),
          transition: _routeTransition,
        );
      case ContinueScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const ContinueScreen(),
          // binding: SplashBinding(),
          transition: _routeTransition,
        );
      case BottomNavBarScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const BottomNavBarScreen(),
          binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case MemoryDetailScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => MemoryDetailScreen(),
          binding: MemoryDetailBindings(),
          transition: _routeTransition,
        );
      case UpdatePasswordScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const UpdatePasswordScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case WriteAMemoryScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const WriteAMemoryScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case RecipientDetailsScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const RecipientDetailsScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case ScheduleMemoryScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const ScheduleMemoryScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case MemoryScheduledSucceccfully.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const MemoryScheduledSucceccfully(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case UpgradePlanScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const UpgradePlanScreen(),
          binding: ChooseYourPlanBindings(),
          transition: _routeTransition,
        );
      case QuestionsScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const QuestionsScreen(),
          binding: QuestionsBindings(),
          transition: _routeTransition,
        );
      case PrivacyPolicyScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const PrivacyPolicyScreen(),
          // binding: QuestionsBindings(),
          transition: _routeTransition,
        );
      case TermsAndConditionScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const TermsAndConditionScreen(),
          // binding: QuestionsBindings(),
          transition: _routeTransition,
        );

      default:
        return null;
    }
  }
}
