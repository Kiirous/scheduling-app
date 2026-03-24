import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_repository.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scheduling_details_state.dart';

class SchedulingDetailsCubit extends Cubit<SchedulingDetailsState> {
  SchedulingDetailsCubit({required this.schedulingId, SchedulingRepository? schedulingRepository})
    : _schedulingRepository = schedulingRepository ?? getIt(),
      super(const SchedulingDetailsState.initial());

  final String schedulingId;
  final SchedulingRepository _schedulingRepository;

  Future<void> loadScheduling() async {
    emit(state.copyWith(isLoading: true));

    final result = await _schedulingRepository.getScheduling(schedulingId: schedulingId);

    emit(switch (result) {
      Success(:final object) => state.copyWith(scheduling: object, isLoading: false),
      Failure() => state.copyWith(isLoading: false),
    });
  }
}
