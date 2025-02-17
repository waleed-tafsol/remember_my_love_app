import 'package:get/get.dart';
import 'package:remember_my_love_app/models/concerns_items.dart';

import '../services/concern_services.dart';

class QuestionsController extends GetxController {
  @override
  void onInit() {
    getConcerns();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  RxList<ConcernsItems> concernsItems = <ConcernsItems>[].obs;
  Rx<String> selectedConcern = ''.obs;


  void onChanged({required String value}) {
    selectedConcern.value = value;
  }

  Future<void> getConcerns() async {
    isLoading.value = true;
    try {
      final List<dynamic> response = await ConcernServices.getConcern();
      concernsItems.value = response.map((item) => ConcernsItems.fromJson(item)).toList();
      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<bool> createConcerns() async {
    isLoading.value = true;
    try {
      final dynamic response = await ConcernServices.createConcern(
        title: selectedConcern.value,
      );
      isLoading.value = false;
      return true;
      print(response.data);
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}
