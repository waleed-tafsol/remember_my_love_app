import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/splash_binding.dart';
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
          binding: SplashBinding(),
          transition: _routeTransition,
        );
      case OnboardingScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const OnboardingScreen(),
          binding: SplashBinding(),
          transition: _routeTransition,
        );

      default:
        return null;
    }
  }
}
