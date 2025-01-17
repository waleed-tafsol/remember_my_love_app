import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remember_my_love_app/view/screens/add_card_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/constants.dart';
import '../../../controllers/CardsController.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import '../../widgets/custom_scaffold.dart';

class CardsScreen extends GetView<CardsController> {
  const CardsScreen({super.key});

  static const routeName = "CardsScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: SingleChildScrollView(
          child: Column(
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
              k2hSizedBox,
              InkWell(
                onTap: () {
                  controller.clearCardData();
                  //  cardViewModel.setIsCardAdd(true);
                  Get.toNamed(AddCardScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: AppColors.kgradientBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                color: AppColors.kGlassColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(293),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: const Icon(
                                  Icons.credit_card,
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text('Add new card'),
                          const Spacer(),
                          Container(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.75, color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: AppColors.kpurple,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              k2hSizedBox,
              Obx(() {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: controller.paymentMethodModel.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final isDefaltCard =
                              controller.paymentMethodModel[index].id ==
                                  controller.selectedCardId.value;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Stack(
                              children: [
                                CreditCardUi(
                                  width: double.infinity,
                                  topLeftColor: AppColors.kgradientBlue,
                                  bottomRightColor: AppColors.kgradientPurple,
                                  cardProviderLogo: Text(controller
                                      .paymentMethodModel[index].card.brand),
                                  cardProviderLogoPosition:
                                      CardProviderLogoPosition.left,
                                  cardHolderFullName: controller
                                          .paymentMethodModel[index].name ??
                                      "",
                                  cardNumber:
                                      "123456789123 ${controller.paymentMethodModel[index].card.last4}",
                                  showValidFrom: false,
                                  validThru:
                                      '${controller.paymentMethodModel[index].card.expMonth}/${controller.paymentMethodModel[index].card.expYear.toString().substring(2)}',
                                ),
                                Positioned(
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: isDefaltCard
                                        ? Colors.green
                                        : AppColors.kGlassColor,
                                    child: IconButton(
                                      onPressed: () {
                                        if (!isDefaltCard) {
                                          controller.setDefaltCard(controller
                                              .paymentMethodModel[index].id);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                isDefaltCard
                                    ? const SizedBox()
                                    : Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                            onPressed: () {
                                              controller.removeCard(controller
                                                  .paymentMethodModel[index]
                                                  .id);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          );
                        });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
