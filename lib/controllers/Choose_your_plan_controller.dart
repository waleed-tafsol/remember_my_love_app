import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/models/PackageModel.dart';
import 'package:remember_my_love_app/models/PaymentMethodModel.dart';
import 'package:remember_my_love_app/models/in_app_model.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';
import 'HomeScreenController.dart';

class ChooseYourPlanController extends GetxController {
  RxBool isLoading = true.obs;
  HomeScreenController homeController = Get.find();

  RxList<PaymentMethodModel> paymentMethodModel = <PaymentMethodModel>[].obs;
  @override
  void onInit() async {
   // selectedPackage.value = homeController.user.value?.package;
    super.onInit();
  }

  RxList<PackagesModel> packages = <PackagesModel>[].obs;
  Rx<PackagesModel?> selectedPackage = PackagesModel().obs;

  Future<bool> getAllPackages() async {
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
      return true;
    }
    else{
      isLoading.value = false;
      return false;
    }

  }

  Future<void> updateSubscription({required InAppModel inAppModel}) async {
    try {
      String jsonData = json.encode(inAppModel.toJson());

      isLoading.value = true;
      Response? response = await ApiService.postRequest(
          ApiConstants.verifyReceipt, {'purchaseDetails': jsonData});
      if(response != null){
        await homeController.getUSer();
        Get.offNamedUntil(SuccessScreen.routeName,
                (route) => route.settings.name == BottomNavBarScreen.routeName,
            arguments: {
              "title": "Successful",
              "subTitle": "Subscription Updated successfully.",
            });
      }

    } finally {
      isLoading.value = false;
    }
  }

 /* Future<void> buyPackage() async {
    Get.toNamed(PaymentScreen.routeName, arguments: {
      "renewUpdateOrBuySub": "Buy",
      "package": selectedPackage.value
    });
    //
  }*/

  Future<void> cancelSubscription() async {
    isLoading.value = true;
    try {
      Response? response =
          await ApiService.patchRequest(ApiConstants.cancelSubscription, {});
      if (response?.data != null) {
        await homeController.getUSer();
        Get.offNamedUntil(SuccessScreen.routeName,
            (route) => route.settings.name == BottomNavBarScreen.routeName,
            arguments: {
              "title": "Successful",
              "subTitle": "Subscription cancelled Successfully.",
            });
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  // Future<void> renewSubscription() async {
  //   isLoading.value = true;
  //   ColoredPrint.green("Fetching Packages");
  //   try {
  //     Response? response =
  //         await ApiService.patchRequest(ApiConstants.renewSubscription, {});
  //     if (response != null) {
  //       if (response.data != null) {
  //         homeController.getUSer();
  //       }
  //       isLoading.value = false;
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //   }
  // }
}
