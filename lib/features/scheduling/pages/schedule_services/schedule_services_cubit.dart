import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedule_services_state.dart';

class ScheduleServicesCubit extends Cubit<ScheduleServicesState> {
  ScheduleServicesCubit() : super(ScheduleServicesState.initial());

  void changeSelectedMonth(DateTime month) {
    emit(state.copyWith(selectedMonth: month));
  }
}
