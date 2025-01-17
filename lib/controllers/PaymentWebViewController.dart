import 'dart:async';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/models/PackageModel.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/CardsScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/ApiConstant.dart';
import '../models/PaymentMethodModel.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';

class Paymentcontroller extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isFocused = true.obs;
  late WebViewController controller;
  HomeScreenController homeController = Get.find();
  Rxn<PaymentMethodModel> defaultCard = Rxn<PaymentMethodModel>();
  late PackagesModel selectedPackage;
  String pmId = "";

  @override
  void onInit() async {
    super.onInit();
    Get.arguments != null
        ? selectedPackage = Get.arguments as PackagesModel
        : null;
    await getCards();
  }

  Future<void> getCards() async {
    isLoading.value = true;

    try {
      ColoredPrint.green("Fetching cards");
      Response? response = await ApiService.getRequest(
        ApiConstants.getDefaltCard,
      );
      if (response != null) {
        if (response.data != "") {
          final jsonResponse = response.data;
          pmId = response.data["id"];
          defaultCard.value = PaymentMethodModel.fromJson(jsonResponse);
        } else {
          // Get.toNamed(CardsScreen.routeName);
        }
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmPayment(String clientSecret) async {
    try {
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
      );

      if (paymentIntent.status == PaymentIntentsStatus.RequiresAction) {
        try {
          // Handle 3D Secure or additional action
          final result = await Stripe.instance
              .handleNextAction(paymentIntent.clientSecret);

          if (result.status == PaymentIntentsStatus.Succeeded) {
            // Navigate to success screen
            Get.offNamedUntil(SuccessScreen.routeName,
                (route) => route.settings.name == BottomNavBarScreen.routeName,
                arguments: {
                  "title": "Payment Successful",
                  "subTitle": "Subscribed successfully.",
                });
          } else {
            // Handle other statuses (e.g., failed, canceled, etc.)
            CustomSnackbar.showError("Payment Failed", "Please try again.");
          }
        } catch (e) {
          // Handle exceptions (e.g., network issues, user cancellation)
          CustomSnackbar.showError("Error", e.toString());
        }
      } else if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        // Handle success if no further action was required
        Get.offNamedUntil(SuccessScreen.routeName,
            (route) => route.settings.name == BottomNavBarScreen.routeName,
            arguments: {
              "title": "Payment Successful",
              "subTitle": "Subscribed successfully.",
            });
      } else {
        // Handle other statuses (e.g., failed, canceled)
        CustomSnackbar.showError(
            "Payment Failed", "Unable to process payment.");
      }
    } catch (error) {
      print('Payment failed: $error');
      // Handle error
    }
  }

  Future<void> buyPackage() async {
    try {
      isLoading.value = true;
      // final paymentMethod = await Stripe.instance.createPaymentMethod(
      //   params: const PaymentMethodParams.card(
      //     paymentMethodData: PaymentMethodData(),
      //   ),
      // );

      final buyResponse =
          await ApiService.postRequest(ApiConstants.buySubscription, {
        "_package": selectedPackage.toJson(),
        "paymentId": pmId,
      });

      await confirmPayment(buyResponse!.data[1]["clientSecret"]);
    } catch (e) {
      // CustomSnackbar.showError("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
