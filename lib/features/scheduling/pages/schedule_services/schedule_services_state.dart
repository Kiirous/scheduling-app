part of 'schedule_services_cubit.dart';

class ScheduleServicesState extends Equatable {
  ScheduleServicesState({
    required this.selectedMonth,
    this.professional,
    required this.loading,
    required this.selectedServices,
    this.daySlots,
  });

  ScheduleServicesState.initial()
    : selectedMonth = DateTime(DateTime.now().year, DateTime.now().month),
      professional = null,
      loading = false,
      selectedServices = [],
      daySlots = null;

  final DateTime selectedMonth;
  final DateTime firstAvailableDay = DateTime.now();
  final ProfessionalDetails? professional;
  final bool loading;
  final List<Service> selectedServices;
  final List<DaySlots>? daySlots;

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
  List<Object?> get props => [selectedMonth, professional, loading, selectedServices, daySlots];

  ScheduleServicesState copyWith({
    DateTime? selectedMonth,
    ProfessionalDetails? professional,
    bool? loading,
    List<Service>? selectedServices,
    ValueGetter<List<DaySlots>?>? daySlots,
  }) {
    return ScheduleServicesState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      professional: professional ?? this.professional,
      loading: loading ?? this.loading,
      selectedServices: selectedServices ?? this.selectedServices,
      daySlots: daySlots != null ? daySlots() : this.daySlots,
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
