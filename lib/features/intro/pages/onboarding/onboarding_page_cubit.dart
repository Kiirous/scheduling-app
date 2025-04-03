import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/firebase/messaging/app_messaging.dart';
import 'package:app_agendamento/features/intro/pages/onboarding/onboarding_page_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_page_state.dart';

class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit(this._actions, {AppLocation? appLocation, AppMessaging? appMessaging})
      : _appLocation = appLocation ?? getIt(),
        _appMessaging = appMessaging ?? getIt(),
        super(const OnboardingPageState.initial());

  OnboardingPageActions? _actions;

  final AppLocation _appLocation;
  final AppMessaging _appMessaging;

  Future<void> initialize() async {
    final locationStatus = await _appLocation.checkStatus();
    final messagingStatus = await _appMessaging.checkStatus();

    print('Permissão de localização: $locationStatus');
    print('Permissão de notificações: $messagingStatus');

    emit(OnboardingPageState(
      showNotificationPage: [
        AppMessagingStatus.notDetermined,
        AppMessagingStatus.denied
      ].contains(messagingStatus),
      showLocationPage: [
        AppLocationStatus.denied,
        AppLocationStatus.deniedForever
      ].contains(locationStatus),
    ));
  }

  Future<void> requestLocationPermission() async {
    final locationStatus = await _appLocation.requestPermission();
    if(locationStatus == AppLocationStatus.deniedForever) {
      await _actions?.showDeniedForeverDialog();
    }
  }

  Future<void> requestNotificationPermission() async {
    final messagingStatus = await _appMessaging.requestPermission();
    if(messagingStatus == AppMessagingStatus.denied) {
      await _actions?.showDeniedForeverDialog();
    }
  }

  void dispose() {
    _actions = null;
  }
}
