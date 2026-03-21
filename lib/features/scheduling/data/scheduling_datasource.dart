import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/scheduling/models/day_slots.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:dio/dio.dart';

class SchedulingDatasource {
  const SchedulingDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, List<Scheduling>>> getUserSchedules(int page, bool futures) async {
    try {
      final response = await _dio.post('/v1-get-user-schedules', data: {'page': page, 'futures': futures});
      return Success(response.data['result'].map<Scheduling>((s) => Scheduling.fromJson(s)).toList());
    } catch (e) {
      return const Failure(null);
    }
  }

  Future<Result<void, List<DaySlots>>> getSchedulingSlots({
    required int duration,
    required String professionalId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _dio.post(
        '/v1-get-scheduling-slots',
        data: {
          'duration': duration,
          'professionalId': professionalId,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        },
      );
      return Success(response.data['result'].map<DaySlots>((s) => Scheduling.fromJson(s)).toList());
    } catch (e) {
      return const Failure(null);
    }
  }

  Future<Result<void, String>> scheduleServices({
    required String professionalId,
    required List<String> servicesId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _dio.post(
        '/v1-schedule-services',
        data: {
          'professionalId': professionalId,
          'serviceIds': servicesId,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        },
      );
      return Success(response.data['result']['id']);
    } catch (e) {
      return const Failure(null);
    }
  }
}
