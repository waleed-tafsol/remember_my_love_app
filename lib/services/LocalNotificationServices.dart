// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// class LocalNotificationService {
//   // Declare the plugin
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

//   // Initialize the plugin
//   Future<void> init() async {
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings(
//             '@mipmap/ic_launcher'); // You can replace with your app's icon

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//     );

//     // Initialize the plugin with the settings
//     // await _flutterLocalNotificationsPlugin.initialize(
//     //   initializationSettings,
//     //   onSelectNotification: onSelectNotification,
//     // );
//   }

//   // Handle notification tap
//   Future<void> onSelectNotification(String? payload) async {
//     // You can handle the notification tap here (e.g., navigate to a specific screen)
//     print("Notification tapped with payload: $payload");
//   }

//   // Show notification
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'default_channel_id', // Channel ID
//       'Default Channel', // Channel Name
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     // Show the notification
//     await _flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails,
//       payload: payload,
//     );
//   }

//   // Show a notification with a custom notification sound
//   Future<void> showCustomSoundNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//     String soundPath = 'assets/sounds/custom_sound.mp3',
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'custom_sound_channel_id', // Channel ID
//       'Custom Sound Channel', // Channel Name
//       sound: RawResourceAndroidNotificationSound('custom_sound'),
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails,
//       payload: payload,
//     );
//   }
// }
