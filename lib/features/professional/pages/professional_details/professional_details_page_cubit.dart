import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professional_details_page_state.dart';

class ProfessionalDetailsPageCubit extends Cubit<ProfessionalDetailsPageState> {
  ProfessionalDetailsPageCubit() : super(const ProfessionalDetailsPageState());

  Future<void> getProfessional(String id) {
    return Future.delayed(const Duration(seconds: 2));
  }
}
