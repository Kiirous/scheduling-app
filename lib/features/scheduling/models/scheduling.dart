import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:app_agendamento/features/professional/models/service.dart';

enum SchedulingStatus { canceled, active }

class Scheduling {
  const Scheduling({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.professional,
    required this.services,
    required this.status,
  });

  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final Professional professional;
  final List<Service> services;
  final SchedulingStatus status;

  factory Scheduling.fromJson(Map<String, dynamic> map) {
    return Scheduling(
      id: map['id'] as String,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      professional: Professional.fromJson(map['professional']),
      services: map['services'].map<Service>((s) => Service.fromJson(s)).toList(),
      status: SchedulingStatus.values.byName(map['status']),
    );
  }
}
