import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPlayerScreenController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void initializeVideo(String videoUrl) {
    if (videoUrl.startsWith('http://') || videoUrl.startsWith('https://')) {
      videoPlayerController = VideoPlayerController.network(videoUrl);
    } else {
      videoPlayerController = VideoPlayerController.file(File(videoUrl));
    }

    // Initialize ChewieController
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: videoPlayerController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(child: Text('Error: $errorMessage'));
      },
    );

    // Initialize the video player controller
    videoPlayerController.initialize().then((_) {
      isInitialized.value = true;
    });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}
