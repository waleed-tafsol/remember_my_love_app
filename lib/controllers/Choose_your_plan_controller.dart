import 'package:get/get.dart';

class ChooseYourPlanController extends GetxController {
  var selectedPlan = 'Monthly'.obs;

  void changePlan(String plan) {
    selectedPlan.value = plan;
  }
}
