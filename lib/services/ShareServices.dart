import 'package:share_plus/share_plus.dart';

import 'DownloadServices.dart';

class ShareService {
  // Method to share an image with text
  static Future<void> shareImageWithText(String text, String imageURL) async {
    try {
      String imagePath =
          await DownloadService.downloadMedia(imageURL, "fileName");
      if (imagePath.isNotEmpty) {
        final result =
            await Share.shareXFiles([XFile(imagePath)], text: 'Great picture');

        if (result.status == ShareResultStatus.success) {
          print('Thank you for sharing the picture!');
        }
      } else {
        print("Image file not found at path: $imagePath");
      }
    } catch (e) {
      print("Error sharing image with text: $e");
    }
  }
}
