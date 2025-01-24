import 'package:firebase_messaging/firebase_messaging.dart';

class AppMessaging {

  AppMessaging(this._messaging) {
    _configureMessaging();
  }

  final FirebaseMessaging _messaging;

  void _configureMessaging() async {
    final status = await _messaging.getNotificationSettings();
    print('Autorização antes de aceitar: ${status.authorizationStatus}');
    final result = await _messaging.requestPermission();
    print('Autorização depois de aceitar: ${result.authorizationStatus}');

    final token = await _messaging.getToken();
    print('TOKEN: $token');

    //RECEBIMENTO DE NOTIFICAÇÕES COM onMessage e onBackgroundMessage
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //CLIQUE EM NOTIFICAÇÕES COM onMessageOpenedApp e getInitialMessage
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      print('Navegar para ${message.data['page']}');
    });

    final message = await _messaging.getInitialMessage();

    _messaging.onTokenRefresh.listen((event) { });

    _messaging.subscribeToTopic('news');

  }
}

@pragma('vm:enrty-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.notification?.title}');
}