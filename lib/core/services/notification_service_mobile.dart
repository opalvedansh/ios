import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const _channelId = 'zepwash_default';
const _channelName = 'ZepWash Notifications';
const _channelDescription = 'Car wash status, payment reminders, and more';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void Function(String route)? _onNavigate;
  String? _userId;
  bool _tokenRefreshListenerSetup = false;

  static Future<void> initialize() async {
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
    );
    await instance._localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await instance._localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: instance._onLocalNotificationTap,
    );
  }

  void setupHandlers(void Function(String route) onNavigate) {
    _onNavigate = onNavigate;

    FirebaseMessaging.onMessage.listen(_showLocalNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _navigate(message.data['type'] as String?);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _navigate(message.data['type'] as String?);
        });
      }
    });
  }

  Future<void> requestPermissionAndSaveToken(String userId) async {
    _userId = userId;

    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final authorized =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;
    if (!authorized) {
      return;
    }

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _saveToken(userId, token);
    }

    if (!_tokenRefreshListenerSetup) {
      _tokenRefreshListenerSetup = true;
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        if (_userId != null) {
          _saveToken(_userId!, newToken);
        }
      });
    }
  }

  Future<void> _saveToken(String userId, String token) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'fcmToken': token});
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) {
      return;
    }

    _localNotifications.show(
      message.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data['type'] as String?,
    );
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    _navigate(response.payload);
  }

  void _navigate(String? type) {
    _onNavigate?.call(_routeForType(type));
  }

  static String _routeForType(String? type) {
    switch (type) {
      case 'cleaning_completed':
      case 'cleaning_missed':
        return '/attendance';
      case 'payment_reminder':
        return '/subscription';
      default:
        return '/home';
    }
  }
}
