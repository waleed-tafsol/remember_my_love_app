import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/PaymentScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'constants/routes.dart';
import 'constants/theme.dart';

import 'services/FirebaseServices.dart';

void main() async {
  // Initialize Firebase Messaging background handler
  // FirebaseService.setupBackgroundHandler();

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51Q9zEn2MzUnaJMmgba4Kn8VJoESujuQtspIE7AqIJXNhjs9HB7F2pHCe6tiNIAfYKmQ9H43hWmPbjpQOY9ovZrfz00xWvqjHVA";
  Stripe.instance.applySettings();

  await FirebaseService.initializeFirebase();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(AuthService(), permanent: true);
  await Future.delayed(Durations.medium1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, _, __) {
      return GlassApp(
          theme: GlassThemeData(
            blur: 10,
          ),
          home: GetMaterialApp(
            title: 'Event Planner',
            debugShowCheckedModeBanner: false,
            theme: CustomTheme().lightTheme,
            initialRoute: authService.isAuthenticated.value
                ? BottomNavBarScreen.routeName
                : SplashScreen.routeName,
            onGenerateRoute: Pages.onGenerateRoute,
            defaultTransition: Transition.rightToLeft,
            smartManagement: SmartManagement.full,
          ));
    });
  }
}
