import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/professional/models/rating.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProfessionalDatasource {
  const ProfessionalDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, ProfessionalDetails>> getProfessional({required String id}) async {
    try {
      final response = await _dio.post('/v1-get-professional', data: {'professionalId': id});
      return Success(ProfessionalDetails.fromJson(response.data['result']));
    } catch (e) {
      debugPrint(e.toString());
      return const Failure(null);
    }
  }

  Future<Result<void, List<Rating>>> getProfessionalRatings({
    required String professionalId,
    required int limit,
    required int page,
  }) async {
    try {
      final response = await _dio.post(
        '/v1-get-professional-ratings',
        data: {'professionalId': professionalId, 'page': page, 'limit': limit},
      );
      return Success(response.data['result'].map<Rating>((s) => Rating.fromJson(s)).toList());
    } catch (e) {
      return const Failure(null);
    }
  }
}
