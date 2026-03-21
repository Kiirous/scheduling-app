import 'package:equatable/equatable.dart';

class Slot extends Equatable {
  const Slot({required this.startDate, required this.endDate});

  final DateTime startDate;
  final DateTime endDate;

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(startDate: DateTime.parse(json['start_date']), endDate: DateTime(json['end_date']));
  }

  @override
  List<Object?> get props => [startDate, endDate];
}
