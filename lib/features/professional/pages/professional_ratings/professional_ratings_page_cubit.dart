import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/rating.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'professional_ratings_page_state.dart';

class ProfessionalRatingsPageCubit extends Cubit<ProfessionalRatingsPageState> {
  ProfessionalRatingsPageCubit({required this.professionalId, ProfessionalRepository? repository})
    : _repository = repository ?? getIt(),
      super(const ProfessionalRatingsPageState(isLoading: true));

  final String professionalId;
  final ProfessionalRepository _repository;

  Future<void> loadRatings() async {
    if (state.isLoading) return;

    final result = await _repository.getProfessionalRatings(
      professionalId: professionalId,
      page: state.page,
      limit: 20,
    );
    emit(switch (result) {
      Success(:final object) => state.copyWith(
        ratings: state.page == 0 ? object : [...state.ratings!, ...object],
        isLoading: false,
        page: state.page + 1,
        finishedLoading: object.length < 20,
      ),
      Failure() => state.copyWith(isLoading: false),
    });
  }
}
