import 'package:flutter/material.dart';
import 'package:app_agendamento/features/intro/widgets/intro_base_page.dart';

import '../../../../core/di/di.dart';
import '../../../../core/widgets/alert/alert_area_cubit.dart';
import '../../../../core/widgets/app_text_button.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: IntroBasePage(
              title: 'Página não encontrada :(',
              body: '',
              imagePath: 'assets/intro/not-found.svg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppTextButton(
                label: 'Voltar',
                onPressed: () {
                  getIt<AlertAreaCubit>().showAlert(
                    const Alert.success(title: 'Este é um alerta legal!'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
