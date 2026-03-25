import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/core/widgets/alert/alert_area_cubit.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_repository.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scheduling_details_state.dart';

class SchedulingDetailsCubit extends Cubit<SchedulingDetailsState> {
  SchedulingDetailsCubit({
    required this.schedulingId,
    SchedulingRepository? schedulingRepository,
    AlertAreaCubit? alertAreaCubit,
  }) : _schedulingRepository = schedulingRepository ?? getIt(),
       _alertAreaCubit = alertAreaCubit ?? getIt(),
       super(const SchedulingDetailsState.initial());

  final String schedulingId;
  final SchedulingRepository _schedulingRepository;
  final AlertAreaCubit _alertAreaCubit;

  Future<void> loadScheduling() async {
    emit(state.copyWith(isLoading: true));

    final result = await _schedulingRepository.getScheduling(schedulingId: schedulingId);

    emit(switch (result) {
      Success(:final object) => state.copyWith(scheduling: object, isLoading: false),
      Failure() => state.copyWith(isLoading: false),
    });
  }

  Future<void> cancelScheduling() async {
    emit(state.copyWith(isLoading: true));

    final result = await _schedulingRepository.cancelScheduling(schedulingId: schedulingId);

    if (result case Success(object: final scheduling)) {
      emit(state.copyWith(isLoading: false, scheduling: scheduling));
      _alertAreaCubit.showAlert(const Alert.success(title: 'Agendacmento cancelado com sucesso!'));
    } else {
      emit(state.copyWith(isLoading: false));
      _alertAreaCubit.showAlert(const Alert.error(title: 'Falha ao cancelar agenadmento!'));
    }
  }
}
