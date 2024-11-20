import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import '../firebase_options.dart'; // Import the generated firebase options file

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

  // Sign out from Firebase and Google
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      ColoredPrint.green("Signed out successfully.");
    } catch (e) {
      ColoredPrint.red("Error signing out: $e");
    }
  }

  // Push Notification Setup
  static void _setupPushNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ColoredPrint.magenta(
          'Received a message in the foreground: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ColoredPrint.magenta(
          'Opened app from notification: ${message.notification?.title}');
    });
  }

  static Future<void> setupBackgroundHandler() async {
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    if (message.notification != null) {
      ColoredPrint.magenta(
          'Background message: ${message.notification?.title}');
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
