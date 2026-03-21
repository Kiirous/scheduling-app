import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/scheduling/data/scheduling_datasource.dart';
import 'package:app_agendamento/features/scheduling/models/day_slots.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';

class SchedulingRepository {
  SchedulingRepository(this._datasource);

  final SchedulingDatasource _datasource;

  Future<Result<void, List<Scheduling>>> getUserSchedules() {
    return _datasource.getUserSchedules();
  }

  Future<Result<void, List<DaySlots>>> getSchedulingSlots({
    required int duration,
    required String professionalId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _datasource.getSchedulingSlots(
      duration: duration,
      professionalId: professionalId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<Result<void, String>> scheduleServices({
    required String professionalId,
    required List<String> servicesId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _datasource.scheduleServices(
      professionalId: professionalId,
      servicesId: servicesId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
