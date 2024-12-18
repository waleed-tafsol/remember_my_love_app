import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/TextConstant.dart';
import '../../../constants/constants.dart';
import '../../../controllers/CardsController.dart';
import '../../widgets/custom_scaffold.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../widgets/gradient_button.dart';

class CardsScreen extends GetView<CardsController> {
  const CardsScreen({super.key});

  static const routeName = "CardsScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Methods",
              style: TextStyleConstants.displayMediumWhite(context)),
          k2hSizedBox,
          Expanded(
            child: Obx(() {
              return controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                            itemCount: controller.paymentMethodModel.length,
                            shrinkWrap: true,
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
                                      bottomRightColor:
                                          AppColors.kgradientPurple,
                                      cardProviderLogo: Text(controller
                                          .paymentMethodModel[index]
                                          .card
                                          .brand),
                                      cardProviderLogoPosition:
                                          CardProviderLogoPosition.left,
                                      cardHolderFullName: controller
                                          .paymentMethodModel[index].name,
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
                                              controller.setDefaltCard(
                                                  controller
                                                      .paymentMethodModel[index]
                                                      .id);
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
                                                  controller.removeCard(
                                                      controller
                                                          .paymentMethodModel[
                                                              index]
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
                            }),
                        k2hSizedBox,
                        InkWell(
                          onTap: () {
                            controller.addANewCard();
                          },
                          child: Text("Add New Card +",
                              style: TextStyleConstants.bodyMediumWhite(context)
                                  .copyWith(
                                decoration: TextDecoration.underline,
                              )),
                        ),
                      ],
                    );
            }),
          ),
          Get.arguments == null
              ? SizedBox()
              : GradientButton(
                  onPressed: () {},
                  text: "Proceed To Payment",
                  gradients: const [Colors.purple, Colors.blue])
        ],
      ),
    );
  }
}
