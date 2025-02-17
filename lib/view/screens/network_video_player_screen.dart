import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/VideoPlayerWidget.dart';

class NetworkVideoPlayerScreen extends StatelessWidget {
  static const routeName = "NetworkVideoPlayerScreen";

  late String videoUrlData;

  NetworkVideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    videoUrlData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network Video Player"),
      ),
      backgroundColor: Colors.black38,
      body: Center(
        child: Container(
          color: Colors.black38,
          height: 30.h,
          width: double.infinity,
          child: Center(
            child: NetworkVideoPlayerWidget(
              videoUrl: videoUrlData,
              showController: true,
            ),
          ),
        ),
      ),
    );
  }
}
