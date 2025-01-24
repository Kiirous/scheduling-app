import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';


class AppCrashlytics {

  AppCrashlytics(this._crashlytics) {
    _configureCrashlytics();
  }

  final FirebaseCrashlytics _crashlytics;

  void _configureCrashlytics() async {
    //Cobre os erros do flutter
    FlutterError.onError = (error) {
      debugPrint('$error');
      _crashlytics.recordFlutterError(error);
    };

    //Cobre erros assincronos
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };

    //Cobre erros do dart
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort);
  }
}