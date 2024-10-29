import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Upload_memory_controller.dart';

class UploadMemoriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadMemoryController>(() => UploadMemoryController());
  }
}
