import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/localVideoPlayerWidgetController.dart';
import '../screens/VideoplayerScreen.dart';

class LocalVideoPlayerWidget extends StatelessWidget {
  final String filePath; // Local file path to the video

  const LocalVideoPlayerWidget({Key? key, required this.filePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoThumbnailController controller =
        Get.put(VideoThumbnailController());
    controller.generateThumbnailForLocalVideo(filePath);
    void _onPlayButtonPressed() {
      Get.toNamed(VideoPlayerScreen.routeName, arguments: filePath);
    }

    return GestureDetector(
      onTap: _onPlayButtonPressed,
      child: Obx(() {
        // Using GetX to observe the thumbnailPath for changes
        if (controller.thumbnailPath.value == null) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(controller.thumbnailPath.value!)),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.play_circle_fill, // Play button icon
                color: Colors.white,
                size: 50,
              ),
            ),
          );
        }
      }),
    );
  }
}

class NetworkVideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const NetworkVideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the VideoThumbnailController and set the thumbnail for network video
    final VideoThumbnailController controller =
        Get.put(VideoThumbnailController());
    controller.setThumbnailForNetworkVideo(videoUrl);

    // Navigate to the VideoPlayerScreen and pass the video URL
    void _onPlayButtonPressed() {
      Get.toNamed(VideoPlayerScreen.routeName, arguments: videoUrl);
    }

    return GestureDetector(
      onTap: _onPlayButtonPressed,
      child: Obx(() {
        if (controller.thumbnailPath.value == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(controller.thumbnailPath.value!)),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 50,
              ),
            ),
          );
        }
      }),
    );
  }
}
