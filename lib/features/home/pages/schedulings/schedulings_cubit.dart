import 'dart:collection';

import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_repository.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedulings_state.dart';

enum SchedulingStatus { future, past }

class SchedulingsCubit extends Cubit<SchedulingsState> {
  SchedulingsCubit({SchedulingRepository? repository, required this.status})
      : _repository = repository ?? getIt(),
        super(const SchedulingsState());

  final SchedulingStatus status;
  final SchedulingRepository _repository;

  Future<void> loadSchedulings() async {
    if (state.isLoading && state.schedulings != null) return;

    emit(state.copyWith(isLoading: true));
    final result = await _repository.getUserSchedules(state.page, status == SchedulingStatus.future);
    emit(switch (result) {
      Success(:final object) => state.copyWith(
        schedulings: state.page == 0 ? object : [...state.schedulings!, ...object],
        isLoading: false,
        page: state.page + 1,
        finishedLoading: object.length < 20,
      ),
      Failure() => state.copyWith(isLoading: false),
    });
  }
}
