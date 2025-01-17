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
import 'package:remember_my_love_app/view/screens/onboarding_screens/Choose_Your_plan_Screen.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';
import '../view/screens/onboarding_screens/PaymentScreen.dart';
import 'HomeScreenController.dart';

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

  @override
  void onInit() async {
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

      // Confirm the payment
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret:
            'pi_3QfUPk2MzUnaJMmg10PkMVPW_secret_YQra52M8IPfnPvdqZoT3g5XPp',
      );

      // Handle successful payment
      print('Payment successful: ${paymentIntent.toJson()}');
    } catch (error) {
      // Handle error
      print('Payment failed: $error');
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
        name: cardHolderName.value, // Cardholder's name
        email: homeController.user.value?.email,
      );

      final payment = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
              paymentMethodData:
                  PaymentMethodData(billingDetails: billingDetails)));
      print(payment.id);

      Response? response = await ApiService.postRequest(
          ApiConstants.attatchCard, {"paymentMethodId": payment.id});
      isLoading.value = false;
      bool routeExists = Get.routeTree.routes.any(
        (route) => route.name == ChooseYourPlanScreen.routeName,
      );

      routeExists
          ? Get.offNamedUntil(ChooseYourPlanScreen.routeName, (route) {
              return route.settings.name == BottomNavBarScreen.routeName;
            })
          : Get.offNamedUntil(CardsScreen.routeName, (route) {
              return route.settings.name == BottomNavBarScreen.routeName;
            });

      return true;
    } catch (exception) {
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
