import 'package:firebase_messaging/firebase_messaging.dart';
import '../utils/exceptions.dart';

class FCMService {
  final FirebaseMessaging _messaging;

  FCMService({FirebaseMessaging? messaging})
      : _messaging = messaging ?? FirebaseMessaging.instance;

  // Request notification permissions
  Future<bool> requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    } catch (e) {
      throw AppException('Failed to request notification permission: $e');
    }
  }

  // Get FCM token
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      throw AppException('Failed to get FCM token: $e');
    }
  }

  // Listen to token refresh
  Stream<String> onTokenRefresh() {
    return _messaging.onTokenRefresh;
  }

  // Configure foreground notification handling
  void configureForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notifications
      // This will be implemented in the app layer
    });
  }

  // Configure background notification handling
  static Future<void> backgroundHandler(RemoteMessage message) async {
    // Handle background notifications
    // This will be implemented in the app layer
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (e) {
      throw AppException('Failed to subscribe to topic: $e');
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
    } catch (e) {
      throw AppException('Failed to unsubscribe from topic: $e');
    }
  }
}
