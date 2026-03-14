import 'package:app_agendamento/features/scheduling/models/slot.dart';

class DaySlots {
  final DateTime date;
  final List<Slot> slots;

  const DaySlots({required this.date, required this.slots});

  factory DaySlots.fromJson(Map<String, dynamic> json) {
    return DaySlots(
      date: DateTime.parse(json['date']),
      slots: json['slots'].map<Slot>((s) => Slot.fromJson(s)).toList(),
    );
  }
}
