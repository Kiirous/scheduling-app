import 'package:app_agendamento/features/auth/models/cellphone.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/cpf.dart';
import '../../models/email.dart';
import '../../models/full_name.dart';
import '../../models/password.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.empty());

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
}
