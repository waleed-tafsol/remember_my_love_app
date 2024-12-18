import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/CardsController.dart';

class CardsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardsController>(() => CardsController());
  }
}
