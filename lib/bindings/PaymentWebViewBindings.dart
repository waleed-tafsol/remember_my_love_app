import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/PaymentWebViewController.dart';

class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Paymentcontroller>(() => Paymentcontroller());
  }
}
