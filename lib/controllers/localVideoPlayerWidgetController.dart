import 'package:get/get.dart';
import 'dart:io';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';

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
    // Generate the thumbnail file
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );

    // Get the cache directory
    Directory cacheDir = await getTemporaryDirectory();

    // Create a custom cache path for the thumbnail file (e.g., 'thumbnail_cache')
    String thumbnailCachePath =
        '${cacheDir.path}/thumbnail_cache/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Create the directory for the thumbnail cache if it doesn't exist
    final cacheDirPath = Directory('${cacheDir.path}/thumbnail_cache');
    if (!await cacheDirPath.exists()) {
      await cacheDirPath.create(recursive: true);
    }

    // Save the thumbnail to the cache directory
    if (fileName != null) {
      final File thumbnailFile = File(thumbnailCachePath);
      await thumbnailFile.writeAsBytes(await fileName.readAsBytes());
      thumbnailPath.value = thumbnailCachePath;

      // You can now use the path in `thumbnailCachePath` for future references.
      // For example, you can store it in a variable to use later:
      ColoredPrint.green('Thumbnail saved in cache: $thumbnailCachePath');
    }
  }
}
