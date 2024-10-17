import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final ImageProvider? backgroundImage;
  final AppBar? appBar;
  final BottomNavigationBar? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final PreferredSizeWidget? bottomSheet;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final List<Widget>? persistentFooterButtons;
  final bool? primary;
  final bool extendBody;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? automaticallyImplyLeading;
  final Color? scaffoldBackgroundColor;
  final Color? drawerScrimColor;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.backgroundImage,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.drawer,
    this.endDrawer,
    this.persistentFooterButtons,
    this.primary,
    this.extendBody = false,
    this.floatingActionButtonLocation,
    this.automaticallyImplyLeading,
    this.scaffoldBackgroundColor,
    this.drawerScrimColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: backgroundImage ?? AssetImage(Image_assets.scaffold_image),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Scaffold(
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            bottomSheet: bottomSheet,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: Colors.transparent,
            drawer: drawer,
            endDrawer: endDrawer,
            persistentFooterButtons: persistentFooterButtons,
            primary: primary ?? true,
            extendBody: extendBody,
            floatingActionButtonLocation: floatingActionButtonLocation,
            body: body,
          ),
        ),
      ),
    );
  }
}
