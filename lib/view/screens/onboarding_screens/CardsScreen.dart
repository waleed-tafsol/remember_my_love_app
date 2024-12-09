import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../widgets/custom_scaffold.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CreditCardWidget(
            cardNumber: "4242424242424",
            expiryDate: "expiryDate",
            cardHolderName: "cardHolderName",
            cvvCode: "cvvCode",
            showBackView: false,
            onCreditCardWidgetChange: (CreditCardBrand brand) {},
          ),
        ],
      ),
    );
  }
}
