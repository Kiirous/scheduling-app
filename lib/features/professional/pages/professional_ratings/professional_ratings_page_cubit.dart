import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/rating.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professional_ratings_page_state.dart';

class ProfessionalRatingsPageCubit extends Cubit<ProfessionalRatingsPageState> {
  ProfessionalRatingsPageCubit({required this.professionalId, ProfessionalRepository? repository})
    : _repository = repository ?? getIt(),
      super(const ProfessionalRatingsPageState(isLoading: true));

  final String professionalId;
  final ProfessionalRepository _repository;

  Future<void> loadRatings() async {
    final result = await _repository.getProfessionalRatings(professionalId: professionalId, page: 0, limit: 20);
    emit(switch (result) {
      Success(:final object) => state.copyWith(ratings: object, isLoading: false),
      Failure() => state.copyWith(isLoading: false),
    });
  }
}
