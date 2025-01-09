import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../models/NotificationModel.dart';
import '../utills/Colored_print.dart';

class WebSocketManager {
  late WebSocketChannel _channel;

  // Define a callback to send notifications to the controller
  final Function(NotificationModel) onNewNotification;

  WebSocketManager({required this.onNewNotification});

  // Connect to the WebSocket server
  void connect(String url) {
    _channel = IOWebSocketChannel.connect(url);

    // Listen for messages
    _channel.stream.listen((message) {
      _handleMessage(message);
    }, onError: (error) {
      ColoredPrint.red('WebSocket Error: $error');
    }, onDone: () {
      ColoredPrint.green('WebSocket connection closed');
    });
  }

  // Handle incoming WebSocket message
  void _handleMessage(String message) {
    try {
      // Assuming the message is a plain text notification
      final newNotification = NotificationModel.fromJson({
        'message': message,
        // Add any other fields if necessary
      });

      // Call the provided callback function with the new notification
      onNewNotification(newNotification);
    } catch (e) {
      ColoredPrint.red('Error parsing WebSocket message: $e');
    }
  }

  // Close the WebSocket connection
  void disconnect() {
    _channel.sink.close();
  }
}
