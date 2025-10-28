import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:dio/dio.dart';

class NotificationsDatasource {
  const NotificationsDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, List<Notification>>> getNotifications(int page) async {
    try {
      final response = await _dio.post('/v1-get-notifications', data: {'page': page});
      return Success(response.data['result'].map<Notification>((s) => Notification.fromJson(s)).toList());
    } catch (e) {
      return const Failure(null);
    }
  }
}
