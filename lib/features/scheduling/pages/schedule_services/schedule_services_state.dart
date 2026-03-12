part of 'schedule_services_cubit.dart';

class ScheduleServicesState extends Equatable {
  ScheduleServicesState({required this.selectedMonth, this.professional, required this.loading});

  ScheduleServicesState.initial()
    : selectedMonth = DateTime(DateTime.now().year, DateTime.now().month),
      professional = null,
      loading = false;

  final DateTime selectedMonth;
  final DateTime firstAvailableDay = DateTime.now();
  final ProfessionalDetails? professional;
  final bool loading;

  List<DateTime> get availableMonths {
    Set<DateTime> months = {};
    for (int i = 0; i < 120; i++) {
      final day = firstAvailableDay.add(Duration(days: i));
      months.add(DateTime(day.year, day.month));
    }

    return months.toList();
  }

  DateTime get lastAvailableDay => firstAvailableDay.add(const Duration(days: 120));

  @override
  List<Object?> get props => [selectedMonth, professional, loading];

  ScheduleServicesState copyWith({DateTime? selectedMonth, ProfessionalDetails? professional, bool? loading}) {
    return ScheduleServicesState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      professional: professional ?? this.professional,
      loading: loading ?? this.loading,
    );
  }
}
