/*
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  Future<void> presentPaymentSheet(String clientSecret) async {
    try {
      // Initialize the payment sheet with the client secret
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Company Name',
          // applePay: PaymentSheetApplePay(merchantCountryCode: 'US'),
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          // style: ThemeMode.light,
        ),
      );

      // Display the payment sheet to the user
      await Stripe.instance.presentPaymentSheet();
      print("Payment completed successfully");
    } catch (e) {
      print("Payment failed: $e");
      // Handle the error (e.g., user canceled the payment)
    }
  }
}
*/
