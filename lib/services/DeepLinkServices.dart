import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'dart:async';

import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';

import '../constants/ApiConstant.dart';
import '../models/memoryModel.dart';

class DeepLinkService {
  final _navigateDebouncer = Debouncer(delay: Duration(milliseconds: 300));
  // Singleton instance
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  // Initialize deep linking
  Future<void> init() async {
    await _initDeepLinks();
  }

  // Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
  }

  Future<void> _initDeepLinks() async {
    try {
      // Handle initial deep link if app was opened from terminated state
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint("Error getting initial URI: $e");
    }

    // Listen for incoming deep links when app is running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('onAppLink: $uri');
        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint("Error listening to URI stream: $err");
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    debugPrint("Deep Link URI: $uri");

    // Extract path segments for easier handling
    final segments = uri.pathSegments;
    if (segments.isEmpty) return;

    switch (segments[0]) {
      case 'memory':
        _handleMemoryDeepLink(segments);
        break;
      // case 'profile':
      // _handleProfileDeepLink(segments);
      // break;
      default:
        debugPrint('Unknown deep link path: ${segments[0]}');
    }
  }

  Future<void> _handleMemoryDeepLink(List<String> segments) async {
    if (segments.length < 2) return;

    _navigateDebouncer.call(() async {
      final String memoryId = segments[1];
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      // _navigateDebouncer.call(() {
      try {
        Response? response = await ApiService.getRequest(
            ApiConstants.findMemories,
            queryParameters: {"id": memoryId});
        if (response != null) {
          Get.back();
          final memory = MemoryModel.fromJson(response.data);
          Get.toNamed(
            MemoryDetailScreen.routeName,
            arguments: memory,
          );

          Get.back();
        }
      } catch (e) {
        Get.back();
      }
    });
  }

  // void _handleProfileDeepLink(List<String> segments) {
  //   if (segments.length < 2) return;

  //   switch (segments[1]) {
  //     case 'edit':
  //       Get.toNamed(EditEventsDetailScreen.routeName);
  //       break;
  //     // Add more profile-related deep link handlers here
  //     default:
  //       debugPrint('Unknown profile action: ${segments[1]}');
  //   }
  // }

  // Helper method to generate deep links (optional)
  String generateEventDeepLink(String eventId) {
    return 'myapp://event/$eventId';
  }

  String generateProfileDeepLink(String action) {
    return 'myapp://profile/$action';
  }
}

// Extension to handle authentication (optional)
extension AuthenticatedDeepLinks on DeepLinkService {
  Future<void> handleAuthenticatedDeepLink(Uri uri) async {
    // Check authentication status
    if (!await isAuthenticated()) {
      // Store the deep link
      await storeDeepLink(uri);
      // Redirect to login
      Get.toNamed('/login');
      return;
    }

    // Process the deep link if authenticated
    _handleDeepLink(uri);
  }

  Future<bool> isAuthenticated() async {
    // Implement your authentication check here
    return false;
  }

  Future<void> storeDeepLink(Uri uri) async {
    // Store the deep link to handle after authentication
    // Implement your storage logic here
  }
}
