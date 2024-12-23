import 'package:get/get.dart';
import 'dart:io';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class VideoThumbnailController extends GetxController {
  var thumbnailPath = Rx<String?>(null);
  var isLoading = false.obs;

  Future<void> generateThumbnailForLocalVideo(String filePath) async {
    isLoading.value = true;

    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: filePath,
      thumbnailPath: (await Directory.systemTemp.createTemp()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );

    thumbnailPath.value = thumbnail.path;
    isLoading.value = false;
  }

  void setThumbnailForNetworkVideo(String videoUrl) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );
    thumbnailPath.value = fileName.path;
  }
}
