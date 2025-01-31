import 'package:dio/dio.dart';

import '../constants/ApiConstant.dart';
import 'ApiServices.dart';

class ConcernServices {

  static Future<Map<String, dynamic>> createConcern({
    required String title
  }) async {
    // Create a map for the payload
    Map<String, dynamic> payload = {
      "concern": title,
    };

    Response? response = await ApiService.patchRequest(
      ApiConstants.updateUserDetails,
      payload,
    );

    return response?.data;
  }

  static Future getConcern() async {
    final response = await ApiService.getRequest(
      ApiConstants.getConcerns,
    );
    if (response!.statusCode == 200 && response.data is List) {
      return response.data;
    }
  }
}