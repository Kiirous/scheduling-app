import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_datasource.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/professional/models/rating.dart';

class ProfessionalRepository {
  const ProfessionalRepository(this._datasource);

  final ProfessionalDatasource _datasource;

  Future<Result<void, ProfessionalDetails>> getProfessional({required String id}) =>
      _datasource.getProfessional(id: id);

  Future<Result<void, List<Rating>>> getProfessionalRatings({
    required String professionalId,
    required int page,
    required int limit,
  }) => _datasource.getProfessionalRatings(professionalId: professionalId, limit: limit, page: page);
}
