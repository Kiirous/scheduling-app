import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_repository.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_next_schedules_state.dart';

class HomeNextSchedulesCubit extends Cubit<HomeNextSchedulesState> {
  HomeNextSchedulesCubit({SchedulingRepository? repository})
    : _repository = repository ?? getIt(),
      super(const HomeNextSchedulesState.empty());

  final SchedulingRepository _repository;

  Future<void> loadSchedulings() async {
    emit(state.copyWith(status: HomeNextSchedulesStatus.loading));
    final result = await _repository.getUserSchedules();

    (switch (result) {
      Success(:final object) => emit(
        state.copyWith(
          schedulings: object,
          status: HomeNextSchedulesStatus.success,
        ),
      ),
      Failure() => emit(state.copyWith(status: HomeNextSchedulesStatus.error)),
    });
  }

  Future<void> setUserNotLoggedIn() async {
    emit(state.copyWith(status: HomeNextSchedulesStatus.notLoggedIn));
  }
}
