import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../../constants/colors_constants.dart';

class LocalVideoPlayerWidget extends StatefulWidget {
  final String filePath; // Local file path to the video

  const LocalVideoPlayerWidget({Key? key, required this.filePath})
      : super(key: key);

  @override
  State<LocalVideoPlayerWidget> createState() => _LocalVideoPlayerWidgetState();
}

class _LocalVideoPlayerWidgetState extends State<LocalVideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false; // Track the playing state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown
        _controller.setLooping(true); // Optional: Loop the video if needed
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Properly dispose the controller
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause(); // Pause the video
      } else {
        _controller.play(); // Play the video
      }
      _isPlaying = _controller.value.isPlaying; // Update the play state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause, // Toggle play/pause on tap
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Background color for video container
        ),
        child: Stack(
          children: [
            // Video player
            VideoPlayer(_controller),
            // Play/Pause button overlay
            Center(
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_circle_fill, // Change icon based on play state
                color: Colors.white,
                size: 50,
              ),
            ),
          ],
        ),
      ),
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
              ? const CircularProgressIndicator():
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

