/*
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/TextConstant.dart';
import '../../constants/colors_constants.dart';
import '../../constants/constants.dart';
import '../../controllers/CardsController.dart';
import '../widgets/Custom_rounded_glass_button.dart';

class AddCardScreen extends GetView<CardsController> {
  static const routeName = "AddCardScreen";

  const AddCardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomRoundedGlassButton(
                      icon: Icons.arrow_back_ios_new,
                      ontap: () {
                        Get.back();
                      }),
                  k2wSizedBox,
                  Text("Payment Methods",
                      style: TextStyleConstants.headlineLargeWhite(context)),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CreditCardWidget(
                cardNumber: controller.cardNumber.value,
                expiryDate: controller.expiryDate.value,
                cardHolderName: controller.cardHolderName.value,
                cvvCode: controller.cvvCode.value,
                showBackView: controller.isCvvFocused.value,
                cardBgColor: AppColors.kSecondaryColor,
                */
/* cardType: !cardViewModel.getIsCardAdd
                      ? cardViewModel.getCardType == 'visa'
                          ? CardType.visa
                          : cardViewModel.getCardType == 'mastercard'
                              ? CardType.mastercard
                              : cardViewModel.getCardType == 'americanExpress'
                                  ? CardType.americanExpress
                                  : cardViewModel.getCardType == 'unionpay'
                                      ? CardType.unionpay
                                      : cardViewModel.getCardType == 'discover'
                                          ? CardType.discover
                                          : cardViewModel.getCardType == 'elo'
                                              ? CardType.elo
                                              : cardViewModel.getCardType ==
                                                      'hipercard'
                                                  ? CardType.hipercard
                                                  : CardType.otherBrand
                      : null,*//*

                //glassmorphismConfig: Glassmorphism.defaultConfig(),
                //backgroundImage: 'assets/card_bg.png',
                obscureCardNumber: false,
                obscureInitialCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                height: 210,
                chipColor: Colors.white,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                width: MediaQuery.of(context).size.width,
                isChipVisible: true,
                isSwipeGestureEnabled: true,
                animationDuration: const Duration(milliseconds: 1000),
                frontCardBorder: Border.all(color: AppColors.kpurple),
                backCardBorder: Border.all(color: AppColors.kpurple),
                */
/* customCardTypeIcons: <customCardTypeIcons>[
                      CustomCardTypeImage(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset(
                          'assets/mastercard.png',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],*//*

                onCreditCardWidgetChange: (CreditCardBrand) {
                  print(CreditCardBrand.brandName);
                },
              ),
              CreditCardForm(
                formKey: controller.formKey,
                cardNumber: controller.cardNumber.value,
                expiryDate: controller.expiryDate.value,
                cardHolderName: controller.cardHolderName.value,
                cvvCode: controller.cvvCode.value,
                onCreditCardModelChange: controller.onCreditCardModelChange,
                autovalidateMode: AutovalidateMode.always,
                obscureCvv: true,
                obscureNumber: false,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                enableCvv: true,
                inputConfiguration: InputConfiguration(
                  cardNumberDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintStyle: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    fillColor: AppColors.kGlassColor,
                    filled: true,
                    focusColor: AppColors.kpurple,
                    //  labelText: 'Number',
                    labelStyle:
                        TextStyle(color: AppColors.kpurple, fontSize: 12.sp),
                    hintText: 'Card Number',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.kpurple),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  expiryDateDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintStyle: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    fillColor: AppColors.kGlassColor,
                    filled: true,
                    focusColor: AppColors.kpurple,
                    //  labelText: 'Number',
                    labelStyle:
                        TextStyle(color: AppColors.kpurple, fontSize: 12.sp),
                    hintText: 'Expiry Date',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.kpurple),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  cvvCodeDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintStyle: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    fillColor: AppColors.kGlassColor,
                    filled: true,
                    focusColor: AppColors.kpurple,
                    //  labelText: 'Number',
                    labelStyle:
                        TextStyle(color: AppColors.kpurple, fontSize: 12.sp),
                    hintText: 'cvv',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.kpurple),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  cardHolderDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintStyle: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    fillColor: AppColors.kGlassColor,
                    filled: true,
                    focusColor: AppColors.kpurple,
                    //  labelText: 'Number',
                    labelStyle:
                        TextStyle(color: AppColors.kpurple, fontSize: 12.sp),
                    hintText: 'Card Holder Name',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.kpurple),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Obx(() {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GradientButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            await controller.callAddCard();
                          }
                        },
                        text: 'Submit',
                        gradients: [
                          AppColors.kgradientPurple,
                          AppColors.kgradientBlue,
                        ],
                      );
              }),
            ],
          );
        }),
      ),
    );
  }
}
*/
