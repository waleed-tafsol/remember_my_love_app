// import 'package:brunos_kitchen/widgets/dialogs/delete_card_confirmation_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';

// import '../utils/custom_buttons.dart';
// import '../utils/custom_colors.dart';
// import '../utils/custom_font_style.dart';
// import '../view_models/auth_view_model.dart';
// import '../view_models/card_view_model.dart';
// import '../widgets/app_bar_with_back_widget.dart';

// class AddCardScreen extends StatefulWidget {
//   const AddCardScreen({super.key});

//   @override
//   State<AddCardScreen> createState() => _AddCardScreenState();
// }

// class _AddCardScreenState extends State<AddCardScreen> {
//   /* final controller = CardFormEditController();

//   @override
//   void initState() {
//     controller.addListener(update);
//     super.initState();
//   }

//   void update() => setState(() {});*/

// /*  @override
//   void dispose() {
//     controller.removeListener(update);
//     controller.dispose();
//     super.dispose();
//   }*/

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CardViewModel>(builder: (context, cardViewModel, child) {
//       return Scaffold(
//         appBar: AppBarWithBackWidget(
//           showPuppy: false,
//           showCart: false,
//           heading: cardViewModel.getIsCardAdd ? 'Add New Card' : 'Card Detail',
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20).w,
//                     child: Visibility(
//                       visible: !cardViewModel.getIsCardAdd,
//                       child: Row(
//                         children: [
//                           Visibility(
//                             visible: cardViewModel.getIsDefaultCard,
//                             child: Container(
//                                 decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20)),
//                                     color: CustomColors.orangeColor),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10.0, vertical: 2).w,
//                                   child: white12w400(data: 'Default'),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                               alignment: Alignment.centerRight,
//                               child: InkWell(
//                                 onTap: () {
//                                   deleteCardConfirmationDialog(
//                                       context: context,
//                                       cardId:
//                                           cardViewModel.getCardDetailData.sId!);
//                                 },
//                                 child: Container(
//                                   decoration: ShapeDecoration(
//                                     //color: CustomColors.orangeColor,
//                                     shape: RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                           width: 0.75,
//                                           color: CustomColors.orangeColor),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   child:  Padding(
//                                     padding: const EdgeInsets.all(10).w,
//                                     child: const Icon(
//                                       Icons.delete_outline,
//                                       size: 20,
//                                       color: CustomColors.orangeColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   /*
//                   CardFormField(
//                     controller: controller,
//                   ),*/
//                   CreditCardWidget(
//                     cardNumber: cardViewModel.getCardNumber,
//                     expiryDate: cardViewModel.getExpiryDate,
//                     cardHolderName: cardViewModel.getCardHolderName,
//                     cvvCode: cardViewModel.getCvvCode,
//                     showBackView: cardViewModel.getIsCvvFocused,
//                     cardBgColor: CustomColors.orangeColor,
//                     cardType: !cardViewModel.getIsCardAdd
//                         ? cardViewModel.getCardType == 'visa'
//                             ? CardType.visa
//                             : cardViewModel.getCardType == 'mastercard'
//                                 ? CardType.mastercard
//                                 : cardViewModel.getCardType == 'americanExpress'
//                                     ? CardType.americanExpress
//                                     : cardViewModel.getCardType == 'unionpay'
//                                         ? CardType.unionpay
//                                         : cardViewModel.getCardType ==
//                                                 'discover'
//                                             ? CardType.discover
//                                             : cardViewModel.getCardType == 'elo'
//                                                 ? CardType.elo
//                                                 : cardViewModel.getCardType ==
//                                                         'hipercard'
//                                                     ? CardType.hipercard
//                                                     : CardType.otherBrand
//                         : null,
//                     //glassmorphismConfig: Glassmorphism.defaultConfig(),
//                     //backgroundImage: 'assets/card_bg.png',
//                     obscureCardNumber: true,
//                     obscureInitialCardNumber: true,
//                     obscureCardCvv: true,
//                     isHolderNameVisible: true,
//                     height: 210.h,
//                     chipColor: CustomColors.whiteColor,
//                     textStyle: const TextStyle(
//                         color: CustomColors.whiteColor,
//                         fontWeight: FontWeight.bold),
//                     width: MediaQuery.of(context).size.width,
//                     isChipVisible: true,
//                     isSwipeGestureEnabled: true,
//                     animationDuration: const Duration(milliseconds: 1000),
//                     frontCardBorder:
//                         Border.all(color: CustomColors.orangeColorTint),
//                     backCardBorder:
//                         Border.all(color: CustomColors.orangeColorTint),
//                     /* customCardTypeIcons: <customCardTypeIcons>[
//                       CustomCardTypeImage(
//                         cardType: CardType.mastercard,
//                         cardImage: Image.asset(
//                           'assets/mastercard.png',
//                           height: 48,
//                           width: 48,
//                         ),
//                       ),
//                     ],*/
//                     onCreditCardWidgetChange: (CreditCardBrand) {
//                       print(CreditCardBrand.brandName);
//                     },
//                   ),
//                   Visibility(
//                     visible: cardViewModel.getIsCardAdd,
//                     child: CreditCardForm(
//                       formKey: cardViewModel.formKey,
//                       cardNumber: cardViewModel.getCardNumber,
//                       expiryDate: cardViewModel.getExpiryDate,
//                       cardHolderName: cardViewModel.getCardHolderName,
//                       cvvCode: cardViewModel.getCvvCode,
//                       onCreditCardModelChange:
//                           cardViewModel.onCreditCardModelChange,
//                       //themeColor: CustomColors.color6,
//                       obscureCvv: true,
//                       obscureNumber: true,
//                       isHolderNameVisible: true,
//                       isCardNumberVisible: true,
//                       isExpiryDateVisible: true,
//                       enableCvv: true,
//                       cardNumberValidator: (String? cardNumber) {
//                         return null;
//                       },
//                       expiryDateValidator: (String? expiryDate) {
//                         return null;
//                       },
//                       cvvValidator: (String? cvv) {
//                         return null;
//                       },
//                       cardHolderValidator: (String? cardHolderName) {
//                         return null;
//                       },
//                       onFormComplete: () {
//                         // callback to execute at the end of filling card data
//                       },
//                       inputConfiguration: InputConfiguration(
//                         cardNumberDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(20).w,
//                           enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                           hintStyle: TextStyle(
//                             fontFamily: 'CircularStd',
//                             fontSize: 14.sp,
//                             color: CustomColors.greyColor,
//                           ),
//                           fillColor: CustomColors.lightGreyColor,
//                           filled: true,
//                           focusColor: CustomColors.orangeColor,
//                           //  labelText: 'Number',
//                           labelStyle: TextStyle(
//                               color: CustomColors.orangeColor, fontSize: 12.sp),
//                           hintText: 'Card Number',
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: CustomColors.orangeColor),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                         ),
//                         expiryDateDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(20).w,
//                           enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                           hintStyle: TextStyle(
//                             fontFamily: 'CircularStd',
//                             fontSize: 14.sp,
//                             color: CustomColors.greyColor,
//                           ),
//                           fillColor: CustomColors.lightGreyColor,
//                           filled: true,
//                           focusColor: CustomColors.orangeColor,
//                           //  labelText: 'Number',
//                           labelStyle: TextStyle(
//                               color: CustomColors.orangeColor, fontSize: 12.sp),
//                           hintText: 'Expiry Date',
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: CustomColors.orangeColor),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                         ),
//                         cvvCodeDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(20).w,
//                           enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                           hintStyle: TextStyle(
//                             fontFamily: 'CircularStd',
//                             fontSize: 14.sp,
//                             color: CustomColors.greyColor,
//                           ),
//                           fillColor: CustomColors.lightGreyColor,
//                           filled: true,
//                           focusColor: CustomColors.orangeColor,
//                           //  labelText: 'Number',
//                           labelStyle: TextStyle(
//                               color: CustomColors.orangeColor, fontSize: 12.sp),
//                           hintText: 'cvv',
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: CustomColors.orangeColor),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                         ),
//                         cardHolderDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(20).w,
//                           enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                           hintStyle: TextStyle(
//                             fontFamily: 'CircularStd',
//                             fontSize: 14.sp,
//                             color: CustomColors.greyColor,
//                           ),
//                           fillColor: CustomColors.lightGreyColor,
//                           filled: true,
//                           focusColor: CustomColors.orangeColor,
//                           //  labelText: 'Number',
//                           labelStyle: TextStyle(
//                               color: CustomColors.orangeColor, fontSize: 12.sp),
//                           hintText: 'Card Holder Name',
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: CustomColors.orangeColor),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15))),
//                         ),
//                       ),

//                     ),
//                   ),
//                   Visibility(
//                     visible: !cardViewModel.getIsDefaultCard &&
//                         !cardViewModel.getIsCardAdd,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20).w,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               black16w500(data: 'Set As Default'),
//                               Transform.scale(
//                                 scale: 0.8,
//                                 child: CupertinoSwitch(
//                                   activeColor: CustomColors.orangeColor,
//                                   value: cardViewModel.getIsDefaultCard,
//                                   onChanged: (isDefault) {
//                                     cardViewModel
//                                         .callDefaultCardApi()
//                                         .then((value) async => {
//                                               if (value)
//                                                 {
//                                                   cardViewModel
//                                                       .setIsDefaultCard(
//                                                           isDefault),
//                                                   context
//                                                       .read<AuthViewModel>()
//                                                       .callSplash(
//                                                           showLoader: true),
//                                                   Navigator.pop(context)
//                                                 }
//                                             });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 100.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   // Spacer(),
// /*
//                   Visibility(
//                     visible: cardViewModel.getIsCardAdd && _showSubmitButton,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: customButton(
//                         colored: true,
//                         text: 'Submit',
//                         onPressed: () async {
//                          await cardViewModel.callAddCard();
//                         },
//                       ),
//                     ),
//                   ),
// */
//                 ],
//               ),
//             ),
//             Visibility(
//               visible: MediaQuery.of(context).viewInsets.bottom == 0 &&
//                   cardViewModel.getIsCardAdd,
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: CustomColors.whiteColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       topRight: Radius.circular(30.0),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(0, 0),
//                         blurRadius: 5,
//                         spreadRadius: 2,
//                         color: Colors.black12,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20).w,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20).w,
//                       child: customButton(
//                         colored: true,
//                         text: 'Submit',
//                         onPressed: () async {
//                           await context
//                               .read<CardViewModel>()
//                               .callAddCard()
//                               .then((value) => {
//                                     if (value)
//                                       {
//                                         Navigator.pop(context),
//                                         context
//                                             .read<AuthViewModel>()
//                                             .callSplash(showLoader: true)
//                                       }
//                                   });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
