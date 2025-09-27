import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_datasource.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';

class ProfessionalRepository {
  const ProfessionalRepository(this._datasource);

  final ProfessionalDatasource _datasource;

  Future<Result<void, ProfessionalDetails>> getProfessional({
    required String id,
  }) => _datasource.getProfessional(id: id);
}
