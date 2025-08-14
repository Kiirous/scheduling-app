import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/core/widgets/alert/alert_area_cubit.dart';
import 'package:app_agendamento/features/auth/data/session/session_cubit.dart';
import 'package:app_agendamento/features/auth/models/cellphone.dart';
import 'package:app_agendamento/features/auth/pages/sign_up/sign_up_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/cpf.dart';
import '../../models/email.dart';
import '../../models/full_name.dart';
import '../../models/password.dart';
import '../../models/sign_up_dto.dart';

part 'sign_up_state.dart';

///Essa estrutura permite que se eu quiser passar um mock para teste, ele aceita, se não pega do getIt
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this._actions, {
    SessionCubit? sessionCubit,
    AlertAreaCubit? alertAreaCubit,
  }) : _sessionCubit = sessionCubit ?? getIt(),
       _alertAreaCubit = alertAreaCubit ?? getIt(),
       super(const SignUpState.empty());

  final SessionCubit _sessionCubit;
  final AlertAreaCubit _alertAreaCubit;
  final SignUpActions _actions;

  void onFullNameChanged(String s) {
    emit(state.copyWith(fullName: FullName.dirty(s)));
  }

  void onCpfChanged(String s) {
    emit(state.copyWith(cpf: Cpf.dirty(s)));
  }

  void onEmailChanged(String s) {
    emit(state.copyWith(email: Email.dirty(s)));
  }

  void onCellphoneChanged(String s) {
    emit(state.copyWith(cellphone: Cellphone.dirty(s)));
  }

  void onPasswordChanged(String s) {
    emit(state.copyWith(password: Password.dirty(s)));
  }

  Future<void> onSignUpPressed() async {
    emit(state.copyWith(isLoading: true));

    final result = await _sessionCubit.signUp(
      SignUpDto(
        fullName: state.fullName.value,
        cpf: state.cpf.value,
        cellphone: state.cellphone.value,
        email: state.email.value,
        password: state.password.value,
      ),
    );

    switch (result) {
      case Success():
        _actions.navToHome();
      case Failure():
        _alertAreaCubit.showAlert(
          const Alert.error(
            title:
                'Não foi possível criar sua conta. Por favor, tente novamente.',
            duration: Duration(seconds: 3),
          ),
        );
    }

    emit(state.copyWith(isLoading: false));
  }
}
