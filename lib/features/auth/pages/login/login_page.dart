import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/features/auth/models/email.dart';
import 'package:app_agendamento/features/auth/models/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_base_page.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'login_page_actions.dart';
import 'login_page_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.redirectTo});

  final String? redirectTo;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageActions {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return BlocProvider(
      create: (context) => LoginPageCubit(this),
      child: BlocBuilder<LoginPageCubit, LoginPageState>(
        builder: (context, state) {
          return AppBasePage(
            title: 'Entrar',
            isLoading: state.isLoading,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: AppLogo()),
                const SizedBox(height: 10),
                Text('Bem-vindo(a)\nde volta!', style: t.heading36Bold, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                AppTextField(
                  id: 'e-mail',
                  title: 'E-mail',
                  hint: 'Informe seu e-mail',
                  textInputType: TextInputType.emailAddress,
                  onChanged: context.read<LoginPageCubit>().onEmailChanged,
                  error: switch (state.email.displayError) {
                    EmailValidationError.empty => 'Campo obrigatório',
                    EmailValidationError.invalid => 'E-mail inválido',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppTextField(
                  id: 'senha',
                  title: 'Senha',
                  hint: 'Informe uma senha forte',
                  textInputType: TextInputType.emailAddress,
                  obscure: true,
                  onChanged: context.read<LoginPageCubit>().onPasswordChanged,
                  error: switch (state.password.displayError) {
                    PasswordValidationError.empty => 'Campo obrigatório',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppElevatedButton(
                  id: 'entrar',
                  label: 'Entrar',
                  onPressed: state.isValid
                      ? () {
                          FocusScope.of(context).unfocus();
                          context.read<LoginPageCubit>().onLoginPressed();
                        }
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void navToHome() {
    if(widget.redirectTo != null) {
      context.go(widget.redirectTo!);
    } else {
      context.go(AppRoutes.home);
    }
  }
}
