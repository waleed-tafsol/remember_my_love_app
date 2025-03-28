import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  static final Dio dio = Dio();

  // Method to download an image or video and save it to device
  static Future<String> downloadMedia(String url, String fileName) async {
    try {
      // Request storage permission on Android (if needed)
      if (Platform.isAndroid) {
        await _requestPermission(Permission.storage);
      }

      // Get the app's document directory (Android, iOS, and other platforms)
      Directory? appDocDir = await getExternalStorageDirectory();
      String savePath = '${appDocDir?.path}/$fileName';

      // Start the download
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          double progress = (received / total) * 100;
          print("Download Progress: $progress%");
        }
      });

      return savePath;
    } catch (e) {
      print("Error downloading media: $e");
      throw Exception("Failed to download media");
    }
  }

  // Request storage permission (Android)
  static Future<void> _requestPermission(Permission permission) async {
    var status = await permission.request();
    if (status != PermissionStatus.granted) {
      print("Permission not granted");
    }
  }
}
