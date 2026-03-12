import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedule_services_state.dart';

class ScheduleServicesCubit extends Cubit<ScheduleServicesState> {
  ScheduleServicesCubit({required this.professionalId, ProfessionalRepository? professionalRepository})
      : _professionalRepository = professionalRepository ?? getIt(),
        super(ScheduleServicesState.initial());

  final String professionalId;
  final ProfessionalRepository _professionalRepository;

  Future<void> getProfessional() async {
    emit(state.copyWith(loading: true));

    final result = await _professionalRepository.getProfessional(id: professionalId);

    emit(switch(result) {
      Success(:final object) => state.copyWith(professional: object, loading: false),
      Failure() => state.copyWith(loading: false),
    });
  }

  void changeSelectedMonth(DateTime month) {
    emit(state.copyWith(selectedMonth: month));
  }
}
