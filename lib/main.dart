import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants/routes.dart';
import 'constants/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: Pages.onGenerateRoute,
            defaultTransition: Transition.rightToLeft,
            smartManagement: SmartManagement.full,
          ));
    });
  }
}
