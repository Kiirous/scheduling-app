import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/features/home/data/notifications_repository.dart';
import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

enum AppMessagingStatus { denied, allowed, notDetermined }

class AppMessaging {
  AppMessaging(this._messaging, this._repository);

  final FirebaseMessaging _messaging;
  final NotificationsRepository _repository;

  Future<AppMessagingStatus> checkStatus() async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus.toApp();
  }

  Future<AppMessagingStatus> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus.toApp();
  }

  void configure() {
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      final notification = Notification.fromJson(remoteMessage.data);
      _repository.markNotificationAsRead(notification.id);
      router.push(notification.page);
    });
  }
}

extension AuthorizationStatusX on AuthorizationStatus {
  AppMessagingStatus toApp() {
    switch (this) {
      case AuthorizationStatus.authorized:
      case AuthorizationStatus.provisional:
        return AppMessagingStatus.allowed;
      case AuthorizationStatus.denied:
        return AppMessagingStatus.denied;
      case AuthorizationStatus.notDetermined:
        return AppMessagingStatus.notDetermined;
    }
  }
}
