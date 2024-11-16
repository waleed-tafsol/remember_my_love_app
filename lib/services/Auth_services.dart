import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import '../constants/ApiConstant.dart';
import 'ApiServices.dart';
import 'Auth_token_services.dart';

class AuthService extends GetxService {
  @override
  void onInit() async {
    await initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    print("Initializing AuthService...");
    if (await _tokenStorage.hasToken()) {
      isAuthenticated.value = true;
      authToken = await _tokenStorage.getToken();
      print("User is authenticated with token: $authToken");
    }
  }

  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  var isAuthenticated = false.obs;
  TokenService _tokenStorage = TokenService();

  String? authToken;

  Future<Map<String, dynamic>> Signup(
      String name, String email, String password, String passCnfrm) async {
    try {
      Response response = await _dio.post(
        ApiConstants.signup,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "passwordConfirm": passCnfrm
        },
      );
      authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!);
      isAuthenticated.value = true;
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );
      authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!);
      isAuthenticated.value = true;
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
    String email,
  ) async {
    try {
      Response response = await _dio.post(
        ApiConstants.forgotPass,
        data: {"email": email},
      );
      /* authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!); 
      isAuthenticated.value = true;*/
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<Map<String, dynamic>> verifyOnetime(String email, int code) async {
    try {
      Response response = await _dio.patch(
        ApiConstants.verifyOTP,
        data: {"email": email, "code": code},
      );
      /* authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!); 
      isAuthenticated.value = true;*/
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<Map<String, dynamic>> resetPass(
      String email, int code, String password, String confirm_pass) async {
    try {
      Response response = await _dio.patch(
        ApiConstants.resetPass,
        data: {
          "email": email,
          "code": code,
          "password": password,
          "passwordConfirm": confirm_pass
        },
      );
      /* authToken = response.data["data"]["token"];
      _tokenStorage.saveToken(authToken!); 
      isAuthenticated.value = true;*/
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data["message"]["error"] ?? "An error occurred");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<void> logout() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final Response? response =
          await ApiService.postRequest(ApiConstants.logout, {});
      if (response != null) {
        Get.back();
        deleteAuthtokenAndNavigate(message: response.data["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAuthtokenAndNavigate({String? message}) async {
    await _tokenStorage.deleteToken();
    authToken = null;
    isAuthenticated.value = false;
    CustomSnackbar.showSuccess("Success", message ?? "Logged Out");
    Get.offAllNamed(SplashScreen.routeName);
  }
}

final AuthService authService = Get.find();
