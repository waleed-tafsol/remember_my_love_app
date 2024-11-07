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
    print("inauth init");
    if (await _tokenStorage.hasToken()) {
      isAuthenticated.value = true;
      print("${isAuthenticated.value} is authenticated");
      authToken = await _tokenStorage.getToken();
    }
    super.onInit();
  }

  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  var isAuthenticated = false.obs;
  TokenService _tokenStorage = TokenService();
  String? authToken;

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

  Future<void> logout() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final Response? response =
          await ApiService.postRequest(ApiConstants.logout, {});
      Get.back();
      if (response != null) {
        _tokenStorage.deleteToken();
        authToken = null;
        isAuthenticated.value = false;
        CustomSnackbar.showSuccess("Success", response.data["message"]);
        Get.offAllNamed(SplashScreen.routeName);
      }
    } catch (e) {
      print(e);
    }
  }
}

final AuthService authService = Get.find();
