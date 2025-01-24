part of 'login_page_cubit.dart';

enum LoginPageStatus { initial, loading, failure, success }

@immutable
class LoginPageState extends Equatable {
  const LoginPageState({
    this.email = '',
    this.password = '',
    this.status = LoginPageStatus.initial,
  });

  final LoginPageStatus status;
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password, status];

  LoginPageState copyWith({
    LoginPageStatus? status,
    String? email,
    String? password,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
