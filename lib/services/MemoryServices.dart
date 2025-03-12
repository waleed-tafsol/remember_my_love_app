import 'package:dio/dio.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import '../constants/ApiConstant.dart';

class MemoryServices {
  static Future<Map<String, dynamic>> create_mem({
    required String title,
    required String description,
    required String category,
    required String deliveryDate,
    required String sendTo,
    List<Map>? recipients,
    required List<dynamic> files,
  }) async {
    // Create a map for the payload
    Map<String, dynamic> payload = {
      "title": title,
      "description": description,
      "category": category,
      "deliveryDate": deliveryDate,
      "sendTo": sendTo,
      "files": files,
    };

    if (recipients != null) {
      payload["recipients"] = recipients;
    }

    Response? response = await ApiService.postRequest(
      ApiConstants.createMemories,
      payload,
    );

    return response?.data;
  }

  static Future<Map<String, dynamic>> update_mem({
    required String title,
    required String id,
    required String description,
    required String category,
    required String deliveryDate,
    required String sendTo,
    List<Map>? recipients,
    required List<dynamic> files,
  }) async {
    // Create a map for the payload
    Map<String, dynamic> payload = {
      "memoryId": id,
      "title": title,
      "description": description,
      "category": category,
      "deliveryDate": deliveryDate,
      "sendTo": sendTo,
      "files": files,
    };

    if (recipients != null) {
      payload["recipients"] = recipients;
    }

    Response? response = await ApiService.patchRequest(
      ApiConstants.updateMemory,
      payload,
    );

    return response?.data;
  }
}
