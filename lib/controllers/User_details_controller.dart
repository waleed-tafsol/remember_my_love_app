import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';

class UserDetailsController extends GetxController {
  RxBool isLoading = true.obs;

  // @override
  // void onInit() {

  // }

  Future<void> getUserDetails() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.getUserDetails);
    } catch (e) {
      // Get.back();
      // CustomSnackbar.showError("Error", e.toString());
    }
  }
  // Future<void> updateUserDetails() {}
  // Future<void> deleteUserDetails() {}
}
