import 'package:app_agendamento/core/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/route/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_divider.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../../../core/widgets/app_text_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/brand/logo.svg'),
                const SizedBox(height: 16),
                SvgPicture.asset('assets/brand/title.svg'),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Olá! Como deseja acessar?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: t.black,
              ),
            ),
            const SizedBox(height: 50),
            AppElevatedButton(
              id: 'entrar',
              label: 'Entrar',
              onPressed: () => context.push(AppRoutes.login.fullPath),
            ),
            const SizedBox(height: 24),
            AppOutLinedButton(
              id: 'cadastrar',
              label: 'Cadastrar',
              onPressed: () => context.push(AppRoutes.signUp.fullPath),
            ),
            const SizedBox(height: 24),
            const AppDivider(text: 'ou'),
            const SizedBox(height: 8),
            AppTextButton(
              id: 'entrar-como-visitante',
              label: 'Entrar como visitante',
              color: t.primary,
              onPressed: () => context.push(AppRoutes.home),
            ),
          ],
        ),
      ),
    );
  }
}
