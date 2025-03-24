import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/firebase/messaging/app_messaging.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_page_state.dart';

class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit({AppLocation? appLocation, AppMessaging? appMessaging})
      : _appLocation = appLocation ?? getIt(),
        _appMessaging = appMessaging ?? getIt(),
        super(const OnboardingPageState.initial());

  final AppLocation _appLocation;
  final AppMessaging _appMessaging;

  Future<void> initialize() async {
    final locationStatus = await _appLocation.checkStatus();
    final messagingStatus = await _appMessaging.checkStatus();

    emit(OnboardingPageState(
      showNotificationPage: [
        AppMessagingStatus.notDetermined,
        AppLocationStatus.denied
      ].contains(messagingStatus),
      showLocationPage: [
        AppLocationStatus.denied,
        AppLocationStatus.deniedForever
      ].contains(locationStatus),
    ));
  }
}
