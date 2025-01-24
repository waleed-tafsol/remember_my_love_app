import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
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

/*void showVideoDialog({required BuildContext context, required String url}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: SizedBox(
        //  width: 300,
        //  height: 250,
          child: NetworkVideoPlayerWidget(videoUrl: url, showController: true,),
        ),
      );
    },
  );
}*/

class NetworkVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool showController;

  NetworkVideoPlayerWidget(
      {Key? key, required this.videoUrl, required this.showController})
      : super(key: key);

  @override
  _NetworkVideoPlayerWidgetState createState() =>
      _NetworkVideoPlayerWidgetState();
}

class _NetworkVideoPlayerWidgetState extends State<NetworkVideoPlayerWidget> {
  late VideoPlayerController _videoPlayercontroller;
  late ChewieController _chewieController;
  var thumbnail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if(widget.showController){
      _initializePlayer();
    }
    else{
      _getThumbnail();
    }
  }

  Future <void> _getThumbnail () async {
    await _downloadAndCacheVideo().then((cacheData) async {
      thumbnail = await VideoThumbnail.thumbnailData(
        video: cacheData.path,
        imageFormat: ImageFormat.JPEG,
   /*     maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,*/
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
  
  Future<File> _downloadAndCacheVideo() async {
    // Check if video is cached already
    final cache = await DefaultCacheManager().getSingleFile(widget.videoUrl);
    return cache;
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
    });
    await _downloadAndCacheVideo().then((fileData){
      _videoPlayercontroller = VideoPlayerController.file(fileData)
        ..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              allowPlaybackSpeedChanging: false,
              aspectRatio: _videoPlayercontroller.value.aspectRatio,
              showControls: widget.showController,
              videoPlayerController: _videoPlayercontroller,
              autoPlay: false,
              looping: false,
            );
            _isLoading = false;
          });
        });
    });

  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayercontroller.dispose();
   //  _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      //   width: 50.w,
      color: AppColors.kTextfieldColor,
      child: Scaffold(
        backgroundColor: AppColors.kTextfieldColor,
        body: Center(
          child:
          _isLoading
              ? CircularProgressIndicator():
          !widget.showController?
          Image.memory(
            thumbnail,
          )
              : Chewie(
                  controller: _chewieController,
                ),
        ),
      ),
    );
  }
}

