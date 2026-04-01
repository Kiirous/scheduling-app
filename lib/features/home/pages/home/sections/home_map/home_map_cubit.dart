import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_map_state.dart';

class HomeMapCubit extends Cubit<HomeMapState> {
  HomeMapCubit({AppLocation? appLocation}) : _appLocation = appLocation ?? getIt(), super(const HomeMapState.initial());

  final AppLocation _appLocation;

  Future<void> loadUserLocation() async {
    final status = await _appLocation.checkStatus();
    emit(state.copyWith(locationStatus: status));

    if(status == AppLocationStatus.allowed) {
      final location = await _appLocation.getLocation();
      emit(state.copyWith(userLocation: location));
    }
  }
}
