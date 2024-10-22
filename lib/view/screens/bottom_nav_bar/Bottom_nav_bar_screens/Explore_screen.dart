import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/splash_screens/Splah_screen.dart';
import 'package:remember_my_love_app/view/widgets/notification_listTile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              CustomGlassButton(
                padding: EdgeInsets.all(4.w),
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  size: 3.h,
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              k3wSizedBox,
              Text("Notifications",
                  style: TextStyleConstants.headlineLargeWhite(context)),
            ],
          ),
          k1hSizedBox,
          // Use a Container to wrap ListView.builder
          Container(
            height: MediaQuery.of(context).size.height *
                0.9, // Adjust the height as needed
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return NotificationListTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}
