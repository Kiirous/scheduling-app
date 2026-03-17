import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_repository.dart';
import 'package:app_agendamento/features/scheduling/models/day_slots.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../professional/models/service.dart';

part 'schedule_services_state.dart';

class ScheduleServicesCubit extends Cubit<ScheduleServicesState> {
  ScheduleServicesCubit({
    required this.professionalId,
    ProfessionalRepository? professionalRepository,
    SchedulingRepository? schedulingRepository,
  }) : _professionalRepository = professionalRepository ?? getIt(),
       _schedulingRepository = schedulingRepository ?? getIt(),
       super(ScheduleServicesState.initial());

  final String professionalId;
  final ProfessionalRepository _professionalRepository;
  final SchedulingRepository _schedulingRepository;

  Future<void> getProfessional() async {
    emit(state.copyWith(loading: true));

    final result = await _professionalRepository.getProfessional(id: professionalId);

    emit(switch (result) {
      Success(:final object) => state.copyWith(professional: object, loading: false),
      Failure() => state.copyWith(loading: false),
    });
  }

  void changeSelectedMonth(DateTime month) {
    emit(state.copyWith(selectedMonth: month));
  }

  Future<void> toggleService(Service service) async {
    if (state.selectedServices.contains(service)) {
      emit(state.copyRemovingService(service));
    } else {
      emit(state.copyAddingService(service));
    }
  }

  Future<void> onRangeChanged(DateTime startDate, DateTime endDate) async {
    final daySlots = await _schedulingRepository.getSchedulingSlots(
      duration: state.selectedServices.fold(0, (previousValue, element) => previousValue + element.duration),
      professionalId: professionalId,
      startDate: startDate,
      endDate: endDate.add(const Duration(days: 1)),
    );

    emit(switch (daySlots) {
      Success(:final object) => state.copyWith(daySlots: object),
      Failure() => state,
    });
  }
}
