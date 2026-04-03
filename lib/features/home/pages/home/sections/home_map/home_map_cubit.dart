import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_map_state.dart';

class HomeMapCubit extends Cubit<HomeMapState> {
  HomeMapCubit({AppLocation? appLocation, ProfessionalRepository? professionalRepository})
    : _appLocation = appLocation ?? getIt(),
      _professionalRepository = professionalRepository ?? getIt(),
      super(const HomeMapState.initial());

  final AppLocation _appLocation;
  final ProfessionalRepository _professionalRepository;

  Future<void> loadUserLocation() async {
    final status = await _appLocation.checkStatus();
    emit(state.copyWith(locationStatus: status));

    if (status == AppLocationStatus.allowed) {
      final location = await _appLocation.getLocation();
      emit(state.copyWith(userLocation: location));
    }
  }

  Future<void> loadProfessionals(Location center, double radius) async {
   final result = await _professionalRepository.getProfessionals(center: center, radius: radius);
   if(result case Success(object: final professionals)) {
     emit(state.copyWith(professionals: professionals));
    }
  }
}
