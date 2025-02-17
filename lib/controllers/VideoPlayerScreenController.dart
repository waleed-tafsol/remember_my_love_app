import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPlayerScreenController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  RxBool isInitialized = false.obs;
  RxBool isBuffering = false.obs; // To track buffering state
  // RxBool isPlaying = false.obs; // To track if video is playing
  // RxBool isPaused = false.obs; // To track if video is paused


  // Function to initialize the video player
  void initializeVideo(String videoUrl) {
    // Check if the video URL is network-based or a local file
    if (videoUrl.startsWith('http://') || videoUrl.startsWith('https://')) {
      // Create VideoPlayerController for network-based video
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    } else {
      videoPlayerController = VideoPlayerController.file(File(videoUrl));
    }

    // Set up Chewie controller with buffering optimization
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false, // Don't autoplay immediately, wait for buffering
      looping: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(child: Text('Error: $errorMessage'));
      },
      placeholder: const Center(
        child: CircularProgressIndicator(), // Placeholder during buffering
      ),
      customControls: const MaterialControls(),
    );

    // Initialize video controller
    videoPlayerController.initialize().then((_) {
      // Video initialized, update the state to true
      isInitialized.value = true;
      // Start playback once initialized
      videoPlayerController.play();
    }).catchError((e) {
      // Handle initialization errors
      isInitialized.value = false;
    });

    // Add listener to track buffering and state changes
    videoPlayerController.addListener(() {
      // Detect buffering
      if (videoPlayerController.value.isBuffering) {
        isBuffering.value = true;
        print("Video is buffering...");
      } else {
        isBuffering.value = false;
        print("Video is playing...");
      }

      // Detect playback state changes
      if (videoPlayerController.value.isPlaying) {
        // if (!isPlaying.value) {
        //   isPlaying.value = true; // Video is now playing
        //   isPaused.value = false; // Reset paused state
        //   print("Video is playing");
        // }
      } else if (!videoPlayerController.value.isPlaying) {
        // if (!isPaused.value) {
        //   isPaused.value = true; // Video is paused
        //   isPlaying.value = false; // Reset playing state
        //   print("Video is paused");
        // }
      } else if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        // Video is completed
        print("Video has completed");
      }
    });
  }

  // Dispose controllers when no longer needed
  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}
