import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import '../../constants/colors_constants.dart';
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


class NetworkVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool showController;

  NetworkVideoPlayerWidget({Key? key, required this.videoUrl,required this.showController}) : super(key: key);

  @override
  _NetworkVideoPlayerWidgetState createState() =>
      _NetworkVideoPlayerWidgetState();
}

class _NetworkVideoPlayerWidgetState extends State<NetworkVideoPlayerWidget> {
  late VideoPlayerController _videoPlayercontroller;
  late ChewieController _chewieController;


  @override
  void initState() {
    super.initState();
    _videoPlayercontroller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        setState(() {});
      });
    _chewieController = ChewieController(
      allowPlaybackSpeedChanging: false,
      showControls: widget.showController,
      videoPlayerController: _videoPlayercontroller,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
   // _videoPlayercontroller.dispose();
   // _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 50.h,
     //   width: 50.w,
        color: AppColors.kPrimaryColor,
        child: Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          body: Center(
            child: _videoPlayercontroller.value.isInitialized
                ? Chewie(
              controller: _chewieController,
            ):  CircularProgressIndicator(),
          ),
        ),
      );
  }
}
