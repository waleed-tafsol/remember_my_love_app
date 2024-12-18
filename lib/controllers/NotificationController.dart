import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../constants/ApiConstant.dart';
import '../models/NotificationModel.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<NotificationModel> notification = <NotificationModel>[].obs;
  @override
  void onInit() async {
    await getNotification();
    super.onInit();
  }

  Future<void> getNotification() async {
    isLoading.value = true;

    try {
      ColoredPrint.green("getting Notification");
      Response? response = await ApiService.getRequest(
        ApiConstants.getAllNotification,
      );
      if (response != null) {
        final List<dynamic> jsonResponse =
            response.data["data"]["notifications"];

        notification.value =
            jsonResponse.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
