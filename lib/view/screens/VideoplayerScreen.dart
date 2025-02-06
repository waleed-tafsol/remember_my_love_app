import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import '../../controllers/VideoPlayerScreenController.dart';

class VideoPlayerScreen extends GetView<VideoPlayerScreenController> {
  static const routeName = "VideoPlayerScreen";

  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String videoUrl = Get.arguments as String;
    controller.initializeVideo(videoUrl);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back(); // Close the full-screen player
          },
        ),
      ),
      body: Center(
        child: Obx(() {
          // Check if the video is initialized
          if (controller.isInitialized.value) {
            return Stack(
              children: [
                Chewie(
                  controller: controller.chewieController,
                ),

                if (controller.isBuffering.value)
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                // Show play/pause status if necessary
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
