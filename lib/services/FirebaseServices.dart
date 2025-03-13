import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../constants/ApiConstant.dart';
import '../controllers/NotificationController.dart';
import '../firebase_options.dart';
import '../models/MemoryModel.dart';
import '../models/NotificationModel.dart';
import '../view/screens/onboarding_screens/Choose_Your_plan_Screen.dart';
import 'ApiServices.dart';

class FirebaseService {
  // Singleton pattern
  static final FirebaseService _instance = FirebaseService._internal();
  FirebaseService._internal();
  factory FirebaseService() => _instance;
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static String? fcmToken;

  // Initialize Firebase
  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        name: 'remember_my_love_app',
        options: DefaultFirebaseOptions.currentPlatform,
      );
      ColoredPrint.green("Firebase Initialized");

      await requestNotificationPermission();

      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        fcmToken = token;
        ColoredPrint.green("FCM Token: $token");
      } else {
        ColoredPrint.red("Failed to get FCM token");
      }

      _setupPushNotifications();
    } catch (e) {
      ColoredPrint.red("Error initializing Firebase: $e");
    }
  }

  // Sign in with Google
  static Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        ColoredPrint.yellow("Google sign-in canceled by user.");
        return null; // User canceled the sign-in
      }

      // Obtain Google authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      ColoredPrint.green("Google sign-in successful.");
      return userCredential.user;
    } catch (e) {
      ColoredPrint.red("Error signing in with Google: $e");
      return null;
    }
  }

  // Sign in with Apple
  static Future<User?> signInWithApple() async {
    try {
      String generateNonce([int length = 32]) {
        const charset =
            '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
        final random = Random.secure();
        return List.generate(
            length, (_) => charset[random.nextInt(charset.length)]).join();
      }

      String sha256ofString(String input) {
        final bytes = utf8.encode(input);
        final digest = sha256.convert(bytes);
        return digest.toString();
      }

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final appleAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );
      final userDetails =
          await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);
      ColoredPrint.green("Apple sign-in successful.");
      return userDetails.user;
    } catch (e) {
      ColoredPrint.red("Error signing in with Apple: $e");
      return null;
    }
  }

  // Sign out from Firebase and Google
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      ColoredPrint.green("Firebase Signed out successfully.");
    } catch (e) {
      ColoredPrint.red("Error signing out: $e");
    }
  }

  // Push Notification Setup
  static void _setupPushNotifications() async {
    // Check if app was opened from a notification
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ColoredPrint.green("message recived");
      if (message.data.isNotEmpty) {
        NotificationController notificationController = Get.find();
        notificationController.handleNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      _handleMessage(message);
    });
  }

  static void _handleMessage(RemoteMessage message) async {
    try {
      Map<String, dynamic> jsondata = jsonDecode(message.data["payload"]);
      ColoredPrint.green("Handling message: $jsondata");

      if (jsondata['flag'] == 'memory') {
        try {
          Response? response = await ApiService.getRequest(
              ApiConstants.findMemories + jsondata['payload'][0]['id']);
          if (response != null) {
            final memory = MemoryModel.fromJson(response.data);
            Get.toNamed(
              MemoryDetailScreen.routeName,
              arguments: memory,
            );
          }
        } catch (e) {
          ColoredPrint.red("Error fetching memory details: $e");
        }
      } else if (jsondata['payload']['flag'] == 'subscription') {
        Get.toNamed(ChooseYourPlanScreen.routeName);
      }
    } catch (e) {
      ColoredPrint.red("Error handling message: $e");
    }
  }

  static Future<void> setupBackgroundHandler() async {
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    if (message.notification != null) {
      ColoredPrint.magenta(
          'Background message: ${message.notification?.title}');

      // Check if the memoryId exists in the payload

      Map<String, dynamic> jsondata = jsonDecode(message.data["payload"]);

      final receivedNotification = NotificationModel.fromJson(jsondata);
      String? memoryId = message.data['memoryId'];
      if (memoryId != null) {
        ColoredPrint.green(
            "Navigating to Memory Detail with memoryId: $memoryId");
        // Navigate to MemoryDetailScreen with memoryId as a parameter
        Get.toNamed(MemoryDetailScreen.routeName, arguments: memoryId);
      }
    } else {
      ColoredPrint.magenta('Background message with no notification');
    }
  }

  // Notification Permissions
  static Future<void> requestNotificationPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      ColoredPrint.green("Notification permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      ColoredPrint.yellow("Notification permission granted provisionally");
    } else {
      ColoredPrint.red("Notification permission denied");
    }
  }
}
