import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/models/PaymentMethodModel.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';
import '../view/screens/onboarding_screens/PaymentWebView.dart';
import 'Choose_your_plan_controller.dart';
import 'HomeScreenController.dart';

class CardsController extends GetxController {
  RxBool isLoading = false.obs;
  HomeScreenController homeController = Get.find();
  RxString selectedCardId = "".obs;

  @override
  void onInit() async {
    await getAllCards();
    super.onInit();
  }

  RxList<PaymentMethodModel> paymentMethodModel = <PaymentMethodModel>[].obs;

  Future<void> getAllCards() async {
    isLoading.value = true;

    try {
      ColoredPrint.green("Fetching cards");
      Response? response = await ApiService.getRequest(
        ApiConstants.getAllCards,
      );
      if (response != null) {
        final List<dynamic> jsonResponse = response.data["paymentMethods"];
        selectedCardId.value = response.data["defaultCard"];
        paymentMethodModel.value =
            jsonResponse.map((e) => PaymentMethodModel.fromJson(e)).toList();
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeCard(String id) async {
    isLoading.value = true;
    try {
      ColoredPrint.green("Adding a new card");
      Response? response = await ApiService.postRequest(
          ApiConstants.deAttatchCard, {"paymentMethodId": id});
      if (response != null) {
        await getAllCards();
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaltCard(String id) async {
    isLoading.value = true;
    try {
      ColoredPrint.green("Adding a new card");
      Response? response = await ApiService.postRequest(
          ApiConstants.setDefaltCard, {"paymentMethodId": id});
      if (response != null) {
        await getAllCards();
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addANewCard() async {
    isLoading.value = true;
    try {
      ColoredPrint.green("Adding a new card");
      Response? response =
          await ApiService.getRequest(ApiConstants.attatchCard);
      if (response != null) {
        // await getAllCards();
        Get.toNamed(PaymentScreen.routeName, arguments: response.data["url"]);
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> buyPackage() async {
  //   ChooseYourPlanController chooseYoyourPlanController = Get.find();
  //   isLoading.value = true;
  //   ColoredPrint.green("Buying Package");
  //   Response? response = await ApiService.patchRequest(
  //     ApiConstants.buySubscription,
  //     {
  //       "packageId": chooseYoyourPlanController.selectedPackage.value?.sId,
  //     },
  //   );
  //   Get.offNamedUntil(SuccessScreen.routeName,
  //       (route) => route.settings.name == BottomNavBarScreen.routeName,
  //       arguments: {
  //         "title": "Congrats ",
  //         "subtitle": "Your Plan has been upgraded successfully",
  //       });
  //   isLoading.value = false;
  // }
}
