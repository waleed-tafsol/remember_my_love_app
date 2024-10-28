import 'package:get/get.dart';
import '../controllers/Questions_controller.dart';

class QuestionsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(() => QuestionsController());
  }
}
