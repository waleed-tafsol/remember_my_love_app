import 'package:dio/dio.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import '../constants/ApiConstant.dart';

class Memoryservices {
  static Future<Map<String, dynamic>> create_mem(
      {required String title,
      required String description,
      required String category,
      required String deliveryDate,
      required String deliveryTime,
      required String sendTo,
      required List<Map> recipients,
      required List<dynamic> files}) async {
    Response? response = await ApiService.postRequest(
      ApiConstants.createMemories,
      {
        "title": title,
        "description": description,
        "category": category,
        "date": deliveryDate,
        "time": deliveryTime,
        "sendTo": sendTo,
        "receivers": recipients,
        "files": files,
      },
    );
    return response?.data;
  }

  // static Future<Map<String, dynamic>?> getAllMemories() async {
  //   Response? response = await ApiService.getRequest(
  //     ApiConstants.getAllMemories,
  //   );
  //   if (response != null) {
  //     return response.data;
  //   } else {
  //     return null;
  //   }
  // }
}
