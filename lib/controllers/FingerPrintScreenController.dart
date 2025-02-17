import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';

import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../services/KeyStoreServices.dart';
import '../services/LocalAuthServices.dart';
import '../utills/CustomSnackbar.dart';

class FingerPrintScreenController extends GetxController {
  RxBool isLoading = false.obs;

  final DeviceKeyManager _deviceKeyManager = DeviceKeyManager();

  @override
  void onInit() async {
    super.onInit();
    await LocalAuthService.hasBiometrics();
    await LocalAuthService.canAuthenticate();
  }

  Future<void> attatchFinger() async {
    if (await LocalAuthService.authenticateUser()) {
      final key = await _deviceKeyManager.generateDeviceSpecificKey();
      ColoredPrint.green(key);
      isLoading.value = true;
      try {
        Response? response =
            await ApiService.patchRequest(ApiConstants.attatchFinger, {
          "validationKey": key,
        });
        if (response != null) {
          Get.back();
          CustomSnackbar.showSuccess(
              "Success", response.data["data"]["message"]);
        }
      } finally {
        isLoading.value = false;
      }
    } else {
      // CustomSnackbar.showError("Error", "Authentication failed");
    }
  }
}
