import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:dio/dio.dart';

class NotificationsDatasource {
  const NotificationsDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, List<Notification>>> loadPendingNotifications() async {
    try {
      final response = await _dio.post('/v1-get-user-schedules');
      return Success(response.data['result'].map<Notification>((s) => Notification.fromJson(s)).toList());
    } catch (e) {
      return const Failure(null);
    }
  }

  Future<Result<void, List<Notification>>> loadReadNotifications() async {
    try {
      final response = await _dio.post('/v1-get-user-schedules');
      return Success(response.data['result'].map<Notification>((s) => Notification.fromJson(s)).toList());
    } catch (e) {
      return const Failure(null);
    }
  }
}
