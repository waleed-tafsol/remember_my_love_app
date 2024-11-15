import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
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
      required String receivingUserName,
      required String receivingUserPassword,
      required List<Map> recipients,
      required String recipientsRelation,
      required List<dynamic> files}) async {
    try {
      Response? response = await ApiService.postRequest(
        ApiConstants.createMemories,
        {
          "title": title,
          "description": description,
          "category": category,
          "date": deliveryDate,
          "time": deliveryTime,
          "sendTo": sendTo,
          "receivingUserName": receivingUserName,
          "receivingUserPassword": receivingUserPassword,
          "recipients": recipients,
          // "recipients": recipients,
          "recipientsRelation": recipientsRelation,
          "files": files,
          // "files": files
        },
      );
      return response?.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }
}
