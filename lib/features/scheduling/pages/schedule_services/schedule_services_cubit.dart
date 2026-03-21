import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/professional/models/service.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_repository.dart';
import 'package:app_agendamento/features/scheduling/models/day_slots.dart';
import 'package:app_agendamento/features/scheduling/models/slot.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_page_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'schedule_services_state.dart';

class ScheduleServicesCubit extends Cubit<ScheduleServicesState> {
  ScheduleServicesCubit(
    this.actions, {
    required this.professionalId,
    ProfessionalRepository? professionalRepository,
    SchedulingRepository? schedulingRepository,
  }) : _professionalRepository = professionalRepository ?? getIt(),
       _schedulingRepository = schedulingRepository ?? getIt(),
       super(ScheduleServicesState.initial());

  ScheduleServicesPageActions? actions;
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

    await updateAvailableSlots();

    if (state.selectedDay != null) {
      final newSlots = state.daySlots!.firstWhere(
        (d) => DateUtils.dateOnly(d.date) == DateUtils.dateOnly(state.selectedDay!),
      );

      final keepSlots = newSlots.slots.any((s) => s.startDate == state.selectedDay);
      if (!keepSlots) {
        emit(state.copyWith(selectedDay: DateUtils.dateOnly(state.selectedDay!)));
      }
    }
  }

  Future<void> onRangeChanged(DateTime startDate, DateTime endDate) async {
    emit(state.copyWith(currentRange: (startDate: startDate, endDate: endDate)));

    return updateAvailableSlots();
  }

  void onDayChanged(DateTime day) {
    emit(
      state.copyWith(
        selectedDay: day,
        selectedDaySlots: state.daySlots!.firstWhere((d) => DateUtils.dateOnly(d.date) == DateUtils.dateOnly(day)),
        selectedSlot: () => null,
      ),
    );
  }

  void onTimeChanged(Slot slot) {
    emit(state.copyWith(selectedSlot: () => slot));
  }

  Future<void> updateAvailableSlots() async {
    if (state.currentRange == null) return;

    emit(state.copyWith(daySlots: () => null));

    final daySlots = await _schedulingRepository.getSchedulingSlots(
      duration: state.selectedServices.fold(0, (previousValue, element) => previousValue + element.duration),
      professionalId: professionalId,
      startDate: state.currentRange!.startDate,
      endDate: state.currentRange!.endDate.add(const Duration(days: 1)),
    );

    if (daySlots case Success(:final object)) {
      final newDaySlots = state.selectedDay != null
          ? object.firstWhereOrNull((d) => DateUtils.dateOnly(d.date) == DateUtils.dateOnly(state.selectedDay!))
          : null;

      emit(state.copyWith(daySlots: () => object, selectedDaySlots: newDaySlots));
    }
  }

  Future<void> scheduleServices() async {
    emit(state.copyWith(loading: true));

    final responses = await Future.wait([
      _schedulingRepository.scheduleServices(
        professionalId: professionalId,
        servicesId: state.selectedServices.map((s) => s.id).toList(),
        startDate: state.selectedSlot!.startDate,
        endDate: state.selectedSlot!.endDate,
      ),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    final result = responses.first;

    if (result case Success(object: final id)) {
      actions?.navToScheduling(id);
    }

    emit(state.copyWith(loading: false));
  }

  @override
  Future<void> close() {
    actions = null;
    return super.close();
  }
}
