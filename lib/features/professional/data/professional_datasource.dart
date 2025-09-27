import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:dio/dio.dart';

class ProfessionalDatasource {
  const ProfessionalDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, ProfessionalDetails>> getProfessional({
    required String id,
  }) async {
    try {
      final response = await _dio.post('/v1-get-user-schedules');
      return Success(ProfessionalDetails.fromJson(response.data['result']));
    } catch (e) {
      return const Failure(null);
    }
  }
}
