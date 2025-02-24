/*
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/models/PaymentMethodModel.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/CardsScreen.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/onboarding_screens/PaymentScreen.dart';
import 'HomeScreenController.dart';
import 'PaymentController.dart';

class CardsController extends GetxController {
  RxBool isLoading = false.obs;
  HomeScreenController homeController = Get.find();
  RxString selectedCardId = "".obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  RxString cardType = ''.obs;
  bool fromPaymentScreen = false;

  @override
  void onInit() async {
    fromPaymentScreen = Get.arguments ?? false;
    await getAllCards();
    super.onInit();
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber.value = creditCardModel!.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  Future<void> confirmPayment() async {
    try {
      final List<String> expMonthYear = expiryDate.value.split('/');

      await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
        number: cardNumber.value,
        cvc: cvvCode.value,
        expirationMonth: int.parse(expMonthYear[0]),
        expirationYear: int.parse(expMonthYear[1]),
      ));

      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret:
            'pi_3QfUPk2MzUnaJMmg10PkMVPW_secret_YQra52M8IPfnPvdqZoT3g5XPp',
      );
    } catch (error) {
      // Handle error
      CustomSnackbar.showError("Error", 'Payment failed: $error');
    }
  }

  Future<bool> callAddCard() async {
    try {
      isLoading.value = true;
      final List<String> expMonthYear = expiryDate.value.split('/');

      await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
        number: cardNumber.value,
        cvc: cvvCode.value,
        expirationMonth: int.parse(expMonthYear[0]),
        expirationYear: int.parse(expMonthYear[1]),
      ));

      // var token = await Stripe.instance.createToken(
      //   CreateTokenParams.card(
      //     params: CardTokenParams(
      //       name: cardHolderName.value,
      //       currency: "usd",
      //       type: TokenType.Card,
      //     ),
      //   ),
      // );

      // String tokenId = token.id;

      final billingDetails = BillingDetails(
        name: cardHolderName.value,
        email: homeController.user.value?.email,
      );

      final payment = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
              paymentMethodData:
                  PaymentMethodData(billingDetails: billingDetails)));

      await ApiService.postRequest(
          ApiConstants.attatchCard, {"paymentMethodId": payment.id});
      isLoading.value = false;

      // // Check if PaymentScreen is in the navigation stack by inspecting the history
      // bool isPaymentScreenInStack = false;

      // for (var route in Get.routing.) {
      //   if (route.settings.name == PaymentScreen.routeName) {
      //     isPaymentScreenInStack = true;
      //     break; // No need to check further once found
      //   }
      // }

      // // If PaymentScreen is found in the stack, fetch cards
      // if (isPaymentScreenInStack) {
      //   await paymentcontroller.getCards();
      // }

      if (Get.routing.previous == PaymentScreen.routeName) {
        Paymentcontroller paymentcontroller = Get.find();
        await paymentcontroller.getCards();
      }

      fromPaymentScreen
          ? Get.offNamedUntil(CardsScreen.routeName, (route) {
              return route.settings.name == PaymentScreen.routeName;
            }, arguments: true)
          : Get.offNamedUntil(CardsScreen.routeName, (route) {
              return route.settings.name == BottomNavBarScreen.routeName;
            });

      return true;
    } catch (exception) {
      CustomSnackbar.showError("Error", 'Payment failed: $exception');
      isLoading.value = false;
      return false;
    }
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
      if (fromPaymentScreen) {
        Paymentcontroller paymentcontroller = Get.find();
        await paymentcontroller.getCards();
      }

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

  void clearCardData() {
    cardNumber.value = "";
    expiryDate.value = "";
    cardHolderName.value = "";
    cvvCode.value = "";
  }
}
*/
