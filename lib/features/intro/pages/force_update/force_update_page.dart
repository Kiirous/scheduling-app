import 'package:app_agendamento/core/device/app_external_launcher.dart';
import 'package:app_agendamento/core/widgets/app_elevated_button.dart';
import 'package:app_agendamento/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: IntroBasePage(
              title: 'Nova atualização',
              body: 'Atualize o app para receber todas as novidades!',
              imagePath: 'assets/intro/force-update.svg',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
              child: AppElevatedButton(
                label: 'Atualizar',
                onPressed: getIt<AppExternalLauncher>().launchStore,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
