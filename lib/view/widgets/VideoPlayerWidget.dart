import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
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

  NetworkVideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<NetworkVideoPlayerWidget> createState() =>
      _NetworkVideoPlayerWidgetState();
}

class _NetworkVideoPlayerWidgetState extends State<NetworkVideoPlayerWidget> {
  String thumbnailPath = "";

  @override
  void initState() {
    // TODO: implement initState
    setThumbnailForNetworkVideo(widget.videoUrl);
    super.initState();
  }

  void setThumbnailForNetworkVideo(String videoUrl) async {
    // Get the cache directory
    Directory cacheDir = await getTemporaryDirectory();

    // Define the thumbnail cache path
    String thumbnailCachePath =
        '${cacheDir.path}/thumbnail_cache/${videoUrl.hashCode}.jpg';

    // Check if the thumbnail already exists in cache
    final File cachedThumbnail = File(thumbnailCachePath);
    if (await cachedThumbnail.exists()) {
      // If thumbnail exists, use the cached thumbnail
      setState(() {
        thumbnailPath = thumbnailCachePath;
      });
      ColoredPrint.green('Thumbnail retrieved from cache: $thumbnailCachePath');
    } else {
      final fileName = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      final cacheDirPath = Directory('${cacheDir.path}/thumbnail_cache');
      if (!await cacheDirPath.exists()) {
        await cacheDirPath.create(recursive: true);
      }
      if (fileName != null) {
        final File thumbnailFile = File(thumbnailCachePath);
        await thumbnailFile.writeAsBytes(await fileName.readAsBytes());
        setState(() {
          thumbnailPath = thumbnailCachePath;
        });
        ColoredPrint.green('Thumbnail saved in cache: $thumbnailCachePath');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onPlayButtonPressed() {
      Get.toNamed(VideoPlayerScreen.routeName, arguments: widget.videoUrl);
      ColoredPrint.blue(thumbnailPath);
    }

    return GestureDetector(
        onTap: _onPlayButtonPressed,
        child: thumbnailPath.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(thumbnailPath)),
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
              ));
  }
}
