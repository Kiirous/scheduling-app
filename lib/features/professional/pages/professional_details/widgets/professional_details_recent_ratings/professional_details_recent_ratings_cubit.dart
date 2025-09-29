import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/rating.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professional_details_recent_ratings_state.dart';

class ProfessionalDetailsRecentRatingsCubit extends Cubit<ProfessionalDetailsRecentRatingsState> {
  ProfessionalDetailsRecentRatingsCubit({ProfessionalRepository? repository})
    : _repository = repository ?? getIt(),
      super(const ProfessionalDetailsRecentRatingsState());

  final ProfessionalRepository _repository;

  Future<void> loadRatings({required String professionalId}) async {
    final result = await _repository.getProfessionalRatings(professionalId: professionalId, page: 0, limit: 3);

    emit(switch (result) {
      Success(:final object) => state.copyWith(status: ProfessionalDetailsRecentRatingsStatus.success, ratings: object),
      Failure() => state.copyWith(status: ProfessionalDetailsRecentRatingsStatus.error),
    });
  }
}
