import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/models/PackageModel.dart';
import 'package:remember_my_love_app/models/PaymentMethodModel.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import 'HomeScreenController.dart';

class ChooseYourPlanController extends GetxController {
  RxBool isLoading = false.obs;
  HomeScreenController homeController = Get.find();

  RxList<PaymentMethodModel> paymentMethodModel = <PaymentMethodModel>[].obs;
  @override
  void onInit() async {
    selectedPackage.value = homeController.user.value?.package;
    await getAllPackages();
    super.onInit();
  }

  RxList<PackagesModel> packages = <PackagesModel>[].obs;
  Rx<PackagesModel?> selectedPackage = PackagesModel().obs;

  Future<void> getAllPackages() async {
    isLoading.value = true;
    ColoredPrint.green("Fetching Packages");
    Response? response = await ApiService.getRequest(
      ApiConstants.getAllPackages,
    );
    if (response != null) {
      List<Map<String, dynamic>> packagesList =
          List<Map<String, dynamic>>.from(response.data["packages"]);
      packages.clear();
      packages.addAll(packagesList
          .map((memoryData) => PackagesModel.fromJson(memoryData))
          .toList());
      isLoading.value = false;
    }
  }
}
