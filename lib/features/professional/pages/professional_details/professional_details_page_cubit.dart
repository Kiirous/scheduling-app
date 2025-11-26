import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professional_details_page_state.dart';

class ProfessionalDetailsPageCubit extends Cubit<ProfessionalDetailsPageState> {
  ProfessionalDetailsPageCubit({ProfessionalRepository? professionalRepository})
    : _professionalRepository =
          professionalRepository ?? getIt<ProfessionalRepository>(),
      super(const ProfessionalDetailsPageState());

  final ProfessionalRepository _professionalRepository;

  Future<void> getProfessional(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _professionalRepository.getProfessional(id: id);
    emit(switch (result) {
      Success(:final object) => state.copyWith(
        professional: object,
        isLoading: false,
      ),
      Failure() => state.copyWith(isLoading: false),
    });
  }
}
