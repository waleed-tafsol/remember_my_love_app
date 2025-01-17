import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/controllers/PaymentWebViewController.dart';
import 'package:remember_my_love_app/models/PackageModel.dart';
import 'package:remember_my_love_app/models/PaymentMethodModel.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/PaymentScreen.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';
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

  Future<void> updateSubscription(String package) async {
    try {
      isLoading.value = true;
      await ApiService.patchRequest(
          ApiConstants.updateSubscription, {"packageId": package});
      await homeController.getUSer();
      Get.offNamedUntil(SuccessScreen.routeName,
          (route) => route.settings.name == BottomNavBarScreen.routeName,
          arguments: {
            "title": "Successfull",
            "subTitle": "Subscription Updated successfully.",
          });
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> buyPackage(String packageSid) async {
    final selectedPackage =
        packages.firstWhere((element) => element.sId == packageSid);
    Get.toNamed(PaymentScreen.routeName, arguments: selectedPackage);
    //
  }

  Future<void> cancelSubscription() async {
    isLoading.value = true;
    try {
      Response? response =
          await ApiService.patchRequest(ApiConstants.cancelSubscription, {});
      if (response?.data != null) {
        homeController.getUSer();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> renewSubscription() async {
    isLoading.value = true;
    ColoredPrint.green("Fetching Packages");
    try {
      Response? response =
          await ApiService.patchRequest(ApiConstants.renewSubscription, {});
      if (response != null) {
        if (response.data != null) {
          homeController.getUSer();
        }
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
