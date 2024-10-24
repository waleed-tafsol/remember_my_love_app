import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Memory_detail_controller.dart';

class MemoryDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemoryDetailController>(() => MemoryDetailController());
  }
}
