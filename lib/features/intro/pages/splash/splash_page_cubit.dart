import 'dart:io';

import 'package:app_agendamento/core/device/app_package_info.dart';
import 'package:app_agendamento/core/device/app_preferences.dart';
import 'package:app_agendamento/core/firebase/messaging/app_messaging.dart';
import 'package:app_agendamento/core/firebase/remote_config/app_remote_config.dart';
import 'package:app_agendamento/features/auth/data/session/session_cubit.dart';
import 'package:app_agendamento/features/auth/models/device.dart';
import 'package:app_agendamento/features/intro/pages/splash/splash_page_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/result.dart';

part 'splash_page_state.dart';

class SplashPageCubit extends Cubit<SplashPageState> {
  SplashPageCubit(
    this._actions, {
    AppRemoteConfig? appRemoteConfig,
    AppPackageInfo? appPackageInfo,
    AppPreferences? appPreference,
    SessionCubit? sessionCubit,
    AppMessaging? appMessaging,
  }) : _appRemoteConfig = appRemoteConfig ?? getIt(),
       _appPackageInfo = appPackageInfo ?? getIt(),
       _appPreference = appPreference ?? getIt(),
       _sessionCubit = sessionCubit ?? getIt(),
       _appMessaging = appMessaging ?? getIt(),
       super(const SplashPageState());

  SplashPageActions? _actions;

  final AppRemoteConfig _appRemoteConfig;
  final AppPackageInfo _appPackageInfo;
  final AppPreferences _appPreference;
  final SessionCubit _sessionCubit;
  final AppMessaging _appMessaging;

  Future<void> initialize() async {
    final results = await Future.wait([
      _initRemoteConfig(),
      _checkLoggedUser(),
      _appMessaging.getInitialMessage(),
      Future.delayed(const Duration(seconds: 2)),
    ]);

    final appStatus = results[0];
    final hasLoggedUser = results[1];
    final notification = results[2];

    _registerDevice();

    if (appStatus == AppStatus.maintenance) {
      _actions?.navToMaintenance();
      return;
    } else if (appStatus == AppStatus.forceUpdate) {
      _actions?.navToForceUpdate();
      return;
    }

    final shouldShowOnboarding = _appPreference.shouldShowOnboarding;

    if (shouldShowOnboarding) {
      _actions?.navToOnboarding();
      return;
    }

    if (hasLoggedUser) {
      _actions?.navToHome();
    } else {
      _actions?.navToAuth();
    }

    if(notification != null) {
      _actions?.navToPath(notification.page);
    }
  }

  Future<AppStatus> _initRemoteConfig() async {
    await _appRemoteConfig.initialize();

    final isMaintenance = _appRemoteConfig.isMaintenance;
    if (isMaintenance) return AppStatus.maintenance;

    final appMinVersion = _appRemoteConfig.appMinVersion;
    final appVersion = await _appPackageInfo.getBuildNumber();

    if (appVersion < appMinVersion) {
      return AppStatus.forceUpdate;
    } else {
      return AppStatus.available;
    }
  }

  Future<bool> _checkLoggedUser() async {
    final result = await _sessionCubit.validateToken();
    return result is Success;
  }

  Future<void> _registerDevice() async {
    final device = Device(
      id: _appPreference.deviceId,
      platform: Platform.operatingSystem,
      buildNumber: await _appPackageInfo.getBuildNumber(),
      locale: Platform.localeName,

    );


  }

  void dispose() {
    _actions = null;
  }
}

enum AppStatus { available, maintenance, forceUpdate }
