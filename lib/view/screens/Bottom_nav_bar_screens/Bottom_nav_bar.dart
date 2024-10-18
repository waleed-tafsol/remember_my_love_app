import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});
  static const routeName = "BottomNavBarScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GlassBottomBar(
        items: [
          GlassBottomBarItem(
            icon: Icon(Icons.home),
            title: GlassText("Home"),
          ),
          GlassBottomBarItem(
            icon: Icon(Icons.search),
            title: GlassText("Search"),
          ),
          GlassBottomBarItem(
            icon: Icon(Icons.settings),
            title: GlassText("Settings"),
          ),
        ],
        onTap: (i) {
          // setState(() {
          //   index = i;
          // });
        },
        // currentIndex: index,
      ),
    );
  }
}
