import 'package:dio/dio.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import '../constants/ApiConstant.dart';
import '../utills/ConvertDateTime.dart';
import '../utills/CustomSnackbar.dart';
import 'Auth_services.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  static Future<Map<String, String>> _getHeaders() async {
    String? authToken = await _getAuthToken();
    return {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
      'offSet': getOffsetInHours(),
    };
  }

  static Future<String?> _getAuthToken() async {
    return authService.authToken;
  }

  static Future<Response?> getRequest(String endpoint,
      {Map<String, String>? queryParameters}) async {
    try {
      final headers = await _getHeaders();
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      ColoredPrint.red(
          "Error: ${e.response.toString()} StatusCode: ${e.response?.statusCode.toString()}    on EndPoint: $endpoint ");
      _handleError(e);
      throw Exception(e.response?.data["message"]["error"][0] ??
          'Check your internet connection');
    }
  }

  static Future<Response?> postRequest(String endpoint, dynamic data) async {
    try {
      final headers = await _getHeaders();

      // Check if data is FormData to set Content-Type appropriately
      final Options options = Options(
        headers: headers,
        contentType:
            data is FormData ? 'multipart/form-data' : 'application/json',
      );

      final Response response = await _dio.post(
        endpoint,
        data: data,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      ColoredPrint.red(
          "Error: ${e.response.toString()} StatusCode: ${e.response?.statusCode.toString()}    on EndPoint: $endpoint ");
      _handleError(e);
      return null;
    }
  }

  static Future<Response?> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final headers = await _getHeaders();
      final response = await _dio.put(endpoint,
          data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  static Future<Response?> patchRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final headers = await _getHeaders();
      final response = await _dio.patch(endpoint,
          data: data, options: Options(headers: headers));
      print(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      throw Exception(e);
    }
  }

  // Static DELETE request
  static Future<Response?> deleteRequest(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response =
          await _dio.delete(endpoint, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // Static error handler
  static void _handleError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          CustomSnackbar.showError(
              'Error', error.response?.data["message"]["error"][0]);
          break;
        case 401:
          authService.deleteAuthtokenAndNavigate();
          // Get.offAllNamed(SignUpScreen.routeName);

          break;
        case 404:
          CustomSnackbar.showError('Error',
              error.response?.data["message"]["error"][0] ?? 'Not found');
          break;
        case 500:
          CustomSnackbar.showError('Error',
              error.response?.data["message"]["error"][0] ?? 'Server error');
          break;
        default:
          CustomSnackbar.showError(
              'Error',
              error.response?.data["message"]["error"][0] ??
                  'Something went wrong');
      }
    } else {
      CustomSnackbar.showError(
          'Error',
          error.response?.data["message"]["error"][0] ??
              'Check your internet connection');
    }
  }
}
