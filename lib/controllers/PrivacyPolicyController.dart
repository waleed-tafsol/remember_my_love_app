
import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import '../constants/ApiConstant.dart';
import '../models/CmsModel.dart';

class PrivacyPolicyController extends GetxController {
  Rx<CmsModel?> cmsModel = Rx<CmsModel?>(null);
  RxBool isLoading = true.obs;


  @override
  void onInit() async {
    super.onInit();
    await fetchCms();
  }

  Future<void> fetchCms() async {
    isLoading.value = true;
    try {
      Response? response = await ApiService.getRequest(ApiConstants.getPrivacyPolicy);
     
      if (response?.statusCode == 200) {
       
          cmsModel.value = CmsModel.fromJson(response!.data["privacyPolicy"]);
      } 
    } finally {
      isLoading.value = false;
    }
  }

}
