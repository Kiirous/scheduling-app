import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:dio/dio.dart';

class SchedulingDatasource {
  const SchedulingDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, List<Scheduling>>> getUserSchedules() async {
    try {
      final response = await _dio.post('/v1-get-user-schedules');
      return Success(
        response.data['result']
            .map<Scheduling>((s) => Scheduling.fromJson(s))
            .toList(),
      );
    } catch (e) {
      return const Failure(null);
    }
  }
}
