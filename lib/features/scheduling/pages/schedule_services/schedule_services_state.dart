part of 'schedule_services_cubit.dart';

class ScheduleServicesState extends Equatable {
  const ScheduleServicesState({required this.selectedMonth});

  ScheduleServicesState.initial() : selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  final DateTime selectedMonth;

  List<DateTime> get availableMonths {
    Set<DateTime> months = {};
    for (int i = 0; i < 120; i++) {
      final day = selectedMonth.add(Duration(days: i));
      months.add(DateTime(day.year, day.month));
    }

    return months.toList();
  }

  @override
  List<Object> get props => [selectedMonth];

  ScheduleServicesState copyWith({DateTime? selectedMonth}) {
    return ScheduleServicesState(selectedMonth: selectedMonth ?? this.selectedMonth);
  }
}
