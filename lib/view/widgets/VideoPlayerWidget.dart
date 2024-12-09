import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final dynamic filePathOrFile; // Can be either File or String

  const VideoPlayerWidget({Key? key, required this.filePathOrFile})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.filePathOrFile is File) {
      _controller = VideoPlayerController.file(widget.filePathOrFile)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    } else if (widget.filePathOrFile is String) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.filePathOrFile))
            ..initialize().then((_) {
              setState(() {});
              _controller.play();
            });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Transform.rotate(
              angle: pi / 2, // Rotate by 90 degrees (pi/2 radians)
              child: VideoPlayer(_controller),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
