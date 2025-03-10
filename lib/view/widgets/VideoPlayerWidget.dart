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

  const LocalVideoPlayerWidget({super.key, required this.filePath});

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
        decoration: const BoxDecoration(
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

  const NetworkVideoPlayerWidget(
      {super.key, required this.videoUrl, required this.showController});

  @override
  _NetworkVideoPlayerWidgetState createState() =>
      _NetworkVideoPlayerWidgetState();
}

class _NetworkVideoPlayerWidgetState extends State<NetworkVideoPlayerWidget> {
  VideoPlayerController? _videoPlayercontroller;
  ChewieController? _chewieController;
  var thumbnail;
  bool _isLoading = true;
  bool _isDisposed = false;

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

  Future<void> _getThumbnail() async {
    if (_isDisposed) return;
    await _downloadAndCacheVideo().then((cacheData) async {
      if (_isDisposed) return;
      thumbnail = await VideoThumbnail.thumbnailData(
        video: cacheData.path,
        imageFormat: ImageFormat.JPEG,
      );
    });
    if (!_isDisposed) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<File> _downloadAndCacheVideo() async {
    final cache = await DefaultCacheManager().getSingleFile(widget.videoUrl);
    return cache;
  }

  Future<void> _initializePlayer() async {
    if (_isDisposed) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final fileData = await _downloadAndCacheVideo();
      if (_isDisposed) return;

      _videoPlayercontroller = VideoPlayerController.file(fileData);
      await _videoPlayercontroller?.initialize();
      
      if (_isDisposed) {
        await _videoPlayercontroller?.dispose();
        return;
      }

      setState(() {
        _chewieController = ChewieController(
          allowPlaybackSpeedChanging: false,
          aspectRatio: _videoPlayercontroller?.value.aspectRatio ?? 16/9,
          showControls: widget.showController,
          videoPlayerController: _videoPlayercontroller!,
          autoPlay: false,
          looping: false,
        );
        _isLoading = false;
      });
    } catch (e) {
      print("Error initializing player: $e");
      if (!_isDisposed) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _cleanup() async {
    if (_isDisposed) return;
    _isDisposed = true;

    try {
      // Stop playback if playing
      if (_videoPlayercontroller?.value.isPlaying ?? false) {
        await _videoPlayercontroller?.pause();
      }

      // Dispose controllers
      await _videoPlayercontroller?.dispose();
      _chewieController?.dispose();

      // Reset controllers
      _videoPlayercontroller = null;
      _chewieController = null;
    } catch (e) {
      print("Error during cleanup: $e");
    }
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      color: AppColors.kTextfieldColor,
      child: Scaffold(
        backgroundColor: AppColors.kTextfieldColor,
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : !widget.showController
                  ? Image.memory(thumbnail)
                  : _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

