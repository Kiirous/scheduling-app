part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.fullName,
    required this.cpf,
    required this.cellphone,
    required this.email,
    required this.password,
    required this.isLoading,
  });

  const SignUpState.empty()
    : fullName = const FullName.pure(),
      cpf = const Cpf.pure(),
      cellphone = const Cellphone.pure(),
      email = const Email.pure(),
      password = const Password.pure(),
      isLoading = false;

  final FullName fullName;
  final Cpf cpf;
  final Cellphone cellphone;
  final Email email;
  final Password password;

  final bool isLoading;

  bool get isValid =>
      Formz.validate([fullName, cpf, cellphone, email, password]);

  @override
  List<Object> get props => [fullName, cpf, cellphone, email, password, isLoading];

  SignUpState copyWith({
    FullName? fullName,
    Cpf? cpf,
    Cellphone? cellphone,
    Email? email,
    Password? password,
    bool? isValid,
    bool? isLoading,
  }) {
    return SignUpState(
      fullName: fullName ?? this.fullName,
      cpf: cpf ?? this.cpf,
      cellphone: cellphone ?? this.cellphone,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
