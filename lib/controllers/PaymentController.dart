import 'dart:async';
import 'dart:convert';
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
  RxString renewUpdateOrBuySub = "Renew".obs;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      renewUpdateOrBuySub.value =
          Get.arguments["renewUpdateOrBuySub"] as String;

      selectedPackage = Get.arguments["package"] as PackagesModel;
    }

    await getCards();
  }

  Future<void> getCards() async {
    isLoading.value = true;

    try {
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

//   final String defaultGooglePay = '''{
//   "provider": "google_pay",
//   "data": {
//     "environment": "TEST",
//     "apiVersion": 2,
//     "apiVersionMinor": 0,
//     "allowedPaymentMethods": [
//       {
//         "type": "CARD",
//         "parameters": {
//           "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//           "allowedCardNetworks": ["MASTERCARD", "VISA"]
//         },
//         "tokenizationSpecification": {
//           "type": "PAYMENT_GATEWAY",
//           "parameters": {
//             "gateway": "stripe",
//             "stripe:version": "2024-12-18.acacia",
//             "stripe:publishableKey": "pk_test_51Q9zEn2MzUnaJMmgba4Kn8VJoESujuQtspIE7AqIJXNhjs9HB7F2pHCe6tiNIAfYKmQ9H43hWmPbjpQOY9ovZrfz00xWvqjHVA"
//           }
//         }
//       }
//     ]
//   }
// }''';

  // Future<void> onGooglePayResult(paymentResult) async {
  //   // final response = await fetchPaymentIntentClientSecret();
  //   final clientSecret = "response['clientSecret']";
  //   final token =
  //       paymentResult['paymentMethodData']['tokenizationData']['token'];
  //   final tokenJson = Map.castFrom(json.decode(token));

  //   final params = PaymentMethodParams.cardFromToken(
  //     paymentMethodData: tokenJson['id'],
  //   );
  //   // Confirm Google pay payment method
  //   await Stripe.instance.confirmPayment(
  //     paymentIntentClientSecret: clientSecret,
  //     data: params,
  //   );
  // }

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

  Future<void> renewSubscription() async {
    isLoading.value = true;
    try {
      Response? response =
          await ApiService.patchRequest(ApiConstants.renewSubscription, {});
      if (response != null) {
        if (response.data != null) {
          homeController.getUSer();
          Get.offNamedUntil(SuccessScreen.routeName,
              (route) => route.settings.name == BottomNavBarScreen.routeName,
              arguments: {
                "title": "Successful",
                "subTitle": "Subscription renewed Successfully.",
              });
        }
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> updateSubscription() async {
    try {
      isLoading.value = true;
      await ApiService.patchRequest(
          ApiConstants.updateSubscription, {"packageId": selectedPackage.sId});
      await homeController.getUSer();
      Get.offNamedUntil(SuccessScreen.routeName,
          (route) => route.settings.name == BottomNavBarScreen.routeName,
          arguments: {
            "title": "Successful",
            "subTitle": "Subscription Updated Successfully.",
          });
    } catch (e) {
    } finally {
      isLoading.value = false;
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
