part of 'schedule_services_cubit.dart';

class ScheduleServicesState extends Equatable {
  ScheduleServicesState({
    required this.selectedMonth,
    this.professional,
    required this.loading,
    required this.selectedServices,
    this.daySlots,
    this.currentRange,
    this.selectedDay,
  });

  ScheduleServicesState.initial()
    : selectedMonth = DateTime(DateTime.now().year, DateTime.now().month),
      professional = null,
      loading = false,
      selectedServices = [],
      daySlots = null,
      currentRange = null,
      selectedDay = null;

  final DateTime selectedMonth;
  final DateTime? selectedDay;
  final DateTime firstAvailableDay = DateTime.now();
  final ProfessionalDetails? professional;
  final bool loading;
  final List<Service> selectedServices;
  final List<DaySlots>? daySlots;
  final ({DateTime startDate, DateTime endDate})? currentRange;

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
  List<Object?> get props => [
    selectedMonth,
    selectedDay,
    firstAvailableDay,
    professional,
    loading,
    selectedServices,
    daySlots,
    currentRange,
  ];

  ScheduleServicesState copyWith({
    DateTime? selectedMonth,
    ProfessionalDetails? professional,
    bool? loading,
    List<Service>? selectedServices,
    ValueGetter<List<DaySlots>?>? daySlots,
    ({DateTime startDate, DateTime endDate})? currentRange,
    DateTime? selectedDay,
  }) {
    return ScheduleServicesState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      professional: professional ?? this.professional,
      loading: loading ?? this.loading,
      selectedServices: selectedServices ?? this.selectedServices,
      daySlots: daySlots != null ? daySlots() : this.daySlots,
      currentRange: currentRange ?? this.currentRange,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  ScheduleServicesState copyAddingService(Service service) {
    final services = List<Service>.from(selectedServices);
    services.add(service);

    return copyWith(selectedServices: services);
  }

  ScheduleServicesState copyRemovingService(Service service) {
    final services = List<Service>.from(selectedServices);
    services.remove(service);

    return copyWith(selectedServices: services);
  }
}
