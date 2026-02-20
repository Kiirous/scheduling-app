import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomFirebaseAnalyticsObserver extends RouteObserver<ModalRoute<dynamic>> {
  CustomFirebaseAnalyticsObserver({
    required this.analytics,
    Function(PlatformException error)? onError,
  }) : _onError = onError;

  final FirebaseAnalytics analytics;
  final void Function(PlatformException error)? _onError;

  void _sendScreenView(Route<dynamic> route) {
    final String? screenName = route.settings.name ;
    print(screenName);
    // if (screenName != null) {
    //   analytics.logScreenView(screenName: screenName).catchError((Object error) {
    //     final onError = _onError;
    //     if (onError == null) {
    //       debugPrint('$FirebaseAnalyticsObserver: $error');
    //     } else {
    //       onError(error as PlatformException);
    //     }
    //   }, test: (Object error) => error is PlatformException);
    // }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _sendScreenView(previousRoute);
    }
  }
}
