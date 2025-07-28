import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/features/auth/pages/sign_up/sign_up_actions.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/route/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../models/cellphone.dart';
import '../../models/cpf.dart';
import '../../models/email.dart';
import '../../models/full_name.dart';
import '../../models/password.dart';
import 'sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpActions {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return BlocProvider(
      create: (context) => SignUpCubit(this),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return AppBasePage(
            title: 'Criar conta',
            isLoading: state.isLoading,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: AppLogo()),
                const SizedBox(height: 10),
                Text(
                  'Cadastre-se',
                  style: t.heading36Bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  title: 'Nome completo',
                  hint: 'Informe seu nome completo',
                  textInputType: TextInputType.name,
                  onChanged: context.read<SignUpCubit>().onFullNameChanged,
                  error: switch(state.fullName.displayError) {
                    FullNameValidationError.empty => 'Campo obrigatório',
                    FullNameValidationError.incomplete => 'Informe seu nome completo',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppTextField(
                  title: 'CPF',
                  hint: 'Informe seu CPF',
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
                  onChanged: context.read<SignUpCubit>().onCpfChanged,
                  error: switch(state.cpf.displayError) {
                    CPFValidationError.empty => 'Campo obrigatório',
                    CPFValidationError.invalid => 'CPF inválido',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppTextField(
                  title: 'Celular',
                  hint: 'Informe seu número de celular',
                  textInputType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()],
                  onChanged: context.read<SignUpCubit>().onCellphoneChanged,
                  error: switch(state.cellphone.displayError) {
                    CellphoneValidationError.empty => 'Campo obrigatório',
                    CellphoneValidationError.invalid => 'Celular inválido',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppTextField(
                  title: 'E-mail',
                  hint: 'Informe seu e-mail',
                  textInputType: TextInputType.emailAddress,
                  onChanged: context.read<SignUpCubit>().onEmailChanged,
                  error: switch(state.email.displayError) {
                    EmailValidationError.empty => 'Campo obrigatório',
                    EmailValidationError.invalid => 'E-mail inválido',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppTextField(
                  title: 'Senha',
                  hint: 'Informe uma senha forte',
                  textInputType: TextInputType.emailAddress,
                  obscure: true,
                  onChanged: context.read<SignUpCubit>().onPasswordChanged,
                  error: switch(state.password.displayError) {
                    PasswordValidationError.empty => 'Campo obrigatório',
                    PasswordValidationError.tooShort => 'Senha muito curta',
                    _ => null,
                  },
                ),
                const SizedBox(height: 24),
                AppElevatedButton(
                  label: 'Cadastrar',
                  onPressed: state.isValid ? () {
                    FocusScope.of(context).unfocus();
                    context.read<SignUpCubit>().onSignUpPressed();
                  } : null,
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
    context.go(AppRoutes.home);
  }
}
