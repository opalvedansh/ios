class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static Future<void> initialize() async {}

  void setupHandlers(void Function(String route) onNavigate) {}

  Future<void> requestPermissionAndSaveToken(String userId) async {}
}
