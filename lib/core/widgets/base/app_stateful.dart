import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/firebase/analytics/app_analytics.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppState<T extends StatefulWidget> extends State<T> {
  Widget builder(BuildContext context, AppTheme theme);

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return builder(context, t);
  }

  AppAnalytics get analytics => getIt<AppAnalytics>();
}
