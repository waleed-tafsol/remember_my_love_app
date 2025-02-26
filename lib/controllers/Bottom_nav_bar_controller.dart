import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Upload_memory_screen.dart';

import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../services/Auth_token_services.dart';
import '../services/DeepLinkServices.dart';

enum SelectedTab { home, memories, add, notification, profile }

class BottomNavController extends GetxController {
  var selectedTab = SelectedTab.home.obs;

  RxBool unreadNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    DeepLinkService().init();
    deleteFileFromAws();
  }

  void changeTab(int index) {
    index == 2
        ? Get.toNamed(
            UploadMemoryScreen.routeName,
          )
        : selectedTab.value = SelectedTab.values[index];
  }

  Future<void> deleteFileFromAws() async {
    TokenService tokenservices = TokenService();

    if (await tokenservices.hasVideoKeys()) {
      final successFullFilesUploads = await tokenservices.getVideoKeys() ?? [];
      if (successFullFilesUploads.isNotEmpty) {
        await ApiService.patchRequest(ApiConstants.deleteMemoryFromS3, {
          "files": successFullFilesUploads.map((file) => file).toList(),
        });

        tokenservices.deleteVideosKeys();
      } else {
        null;
      }
    }
  }
}
