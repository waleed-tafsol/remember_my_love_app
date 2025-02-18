
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../constants/ApiConstant.dart';
import '../models/CmsModel.dart';
import '../services/ApiServices.dart';


class TermsAndConditionsController extends GetxController {
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
      Response? response = await ApiService.getRequest(ApiConstants.getTermsAndCondition);
     
      if (response?.statusCode == 200) {
       
          cmsModel.value = CmsModel.fromJson(response!.data["termsAndConditions"]);
      } 
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
