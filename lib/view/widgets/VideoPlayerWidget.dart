import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPlayerWidget extends StatefulWidget {
  final dynamic filePathOrFile;
  const VideoPlayerWidget({Key? key, required this.filePathOrFile})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  late Future<String> _thumbnailPath;

  @override
  void initState() {
    super.initState();

    // Generate the thumbnail if it's a local file
    // if (widget.filePathOrFile is File) {
    //   _thumbnailPath = _generateThumbnail(widget.filePathOrFile);
    // }

    // // Initialize the video controller
    // if (widget.filePathOrFile is File) {
    //   _controller = VideoPlayerController.file(widget.filePathOrFile)
    //     ..initialize().then((_) {
    //       setState(() {});
    //     });
    // } else if (widget.filePathOrFile is String) {
    //   _controller =
    //       VideoPlayerController.networkUrl(Uri.parse(widget.filePathOrFile))
    //         ..initialize().then((_) {
    //           setState(() {});
    //         });
    // }
  }

  // Generate the thumbnail for local video files
  Future<String> _generateThumbnail(File videoFile) async {
    // final thumbnail = await VideoThumbnail.thumbnailFile(
    //   video: videoFile.path,
    //   thumbnailPath: (await Directory.systemTemp.createTemp()).path,
    //   imageFormat: ImageFormat.JPEG,
    //   quality: 75,
    // );
    return "thumbnail";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Show the video in full-screen dialog
  // void _showVideoDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       bool isDialogPlaying = _controller.value.isPlaying;
  //       return StatefulBuilder(
  //         builder: (context, setStateDialog) {
  //           return Stack(
  //             alignment: Alignment.center,
  //             // fit: StackFit.expand,
  //             children: [
  //               Center(child: VideoPlayer(_controller)),
  //               IconButton(
  //                 icon: Icon(
  //                   isDialogPlaying ? Icons.pause : Icons.play_arrow,
  //                   color: Colors.white,
  //                   size: 40,
  //                 ),
  //                 onPressed: () {
  //                   setStateDialog(() {
  //                     if (isDialogPlaying) {
  //                       _controller.pause();
  //                     } else {
  //                       _controller.play();
  //                     }
  //                     isDialogPlaying = !isDialogPlaying;
  //                   });
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _showVideoDialog(context);
      },
      child: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder<String>(
                  future: _thumbnailPath,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image.file(
                        File(snapshot.data!),
                        fit: BoxFit.cover,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                // : Transform.rotate(
                //     angle: pi / 2,
                //     child: Image.network(
                //       widget.filePathOrFile is String
                //           ? widget.filePathOrFile
                //           : '',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.play_circle_fill,
                //     color: Colors.white,
                //     size: 50,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       _controller.play();

                //       _showVideoDialog(context);
                //     });
                //   },
                // ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
