import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/bindings/EditProfileBindings.dart';
import 'package:remember_my_love_app/bindings/OtopBindings.dart';
import 'package:remember_my_love_app/bindings/PrivacyPolicyBindings.dart';
import 'package:remember_my_love_app/bindings/TermsAndConditionBindings.dart';
import 'package:remember_my_love_app/bindings/UpgradePlanBindings.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/forgot_pass_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Upload_memory_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/FingerPrintScreen.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Choose_Your_plan_Screen.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Continue_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Privacy_policy_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Terms_and_condition_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/update_password_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Schedule_memory_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Write_a_memory.dart';
import '../bindings/AuthBindings.dart';
import '../bindings/Bottom_nav_bar_bindings.dart';
import '../bindings/FingerPrintScreenBindings.dart';
import '../bindings/Questions_bindings.dart';
import '../bindings/Update_Password_bindinga.dart';
import '../bindings/Upload_memories_bindings.dart';
import '../bindings/splash_binding.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/EditProfileScreen.dart';
import '../view/screens/network_video_player_screen.dart';
import '../view/screens/onboarding_screens/Questions_screen.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Recipient_details_screen.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../view/screens/auth_screens/sign_up_screen.dart';
import '../view/screens/auth_screens/Splash_screen.dart';
import '../view/screens/auth_screens/OTP_screen.dart';
import '../view/screens/auth_screens/ResetPass_screen.dart';

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
      case OtpScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => OtpScreen(),
          binding: OtpBindings(),
          transition: _routeTransition,
        );
      case ResetpassScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const ResetpassScreen(),
          //binding: SplashBinding(),
          transition: _routeTransition,
        );
      case ForgotPassScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => ForgotPassScreen(),
          binding: OtpBindings(),
          transition: _routeTransition,
        );
      case SignUpScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => SignUpScreen(),
          binding: AuthBindings(),
          transition: _routeTransition,
        );
      case UploadMemoryScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => UploadMemoryScreen(),
          binding: UploadMemoriesBindings(),
          transition: _routeTransition,
        );
      case ChooseYourPlanScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const ChooseYourPlanScreen(),
          binding: ChooseYourPlanBindings(),
          transition: _routeTransition,
        );
  /*    case PaymentScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const PaymentScreen(),
          binding: PaymentBindings(),
          transition: _routeTransition,
        );*/
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
      case FingerPrintScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const FingerPrintScreen(),
          binding: FingerPrintScreenBindings(),
          transition: _routeTransition,
        );
      case MemoryDetailScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const MemoryDetailScreen(),
          // binding: MemoryDetailBindings(),
          transition: _routeTransition,
        );
      case UpdatePasswordScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => UpdatePasswordScreen(),
          binding: UpdatePasswordBindings(),
          transition: _routeTransition,
        );
      case WriteAMemoryScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => WriteAMemoryScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case RecipientDetailsScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => RecipientDetailsScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      case ScheduleMemoryScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const ScheduleMemoryScreen(),
           binding: UploadMemoriesBindings(),
          transition: _routeTransition,
        );
      case SuccessScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const SuccessScreen(),
          // binding: BottomNavBarBindings(),
          transition: _routeTransition,
        );
      // case UpgradePlanScreen.routeName:
      //   return GetPageRoute(
      //     settings: settings,
      //     page: () => const UpgradePlanScreen(),
      //     binding: ChooseYourPlanBindings(),
      //     transition: _routeTransition,
      //   );
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
          binding: PrivacyPolicyBindings(),
          transition: _routeTransition,
        );
      case TermsAndConditionScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const TermsAndConditionScreen(),
          binding: TermsAndConditionBindings(),
          transition: _routeTransition,
        );
      case EditProfileScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => EditProfileScreen(),
          binding: EditProfileBindings(),
          transition: _routeTransition,
        );
    /*  case CardsScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const CardsScreen(),
          binding: CardsBindings(),
          transition: _routeTransition,
        );
      case AddCardScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => const AddCardScreen(),
          binding: CardsBindings(),
          transition: _routeTransition,
        );*/
      case NetworkVideoPlayerScreen.routeName:
        return GetPageRoute(
          settings: settings,
          page: () => NetworkVideoPlayerScreen(),
          // binding: CardsBindings(),
          transition: _routeTransition,
        );
      // case VideoPlayerScreen.routeName:
      //   return GetPageRoute(
      //     settings: settings,
      //     page: () => const VideoPlayerScreen(),
      //     binding: VideoPlayerBinding(),
      //     transition: _routeTransition,
      //   );


      default:
        return null;
    }
  }
}
