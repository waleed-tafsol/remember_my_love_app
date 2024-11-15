import 'package:get/get.dart';
import 'package:remember_my_love_app/models/memoryModel.dart';
import 'package:remember_my_love_app/services/MemoryServices.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() async {
    getmemories();
    super.onInit();
  }

  void getmemories() async {
    ColoredPrint.red("getmemories");
    await Memoryservices.all_mem();
  }

  static List<MemoryModel> memories = [];
}
