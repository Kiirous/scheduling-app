import 'package:app_agendamento/core/device/app_external_launcher.dart';
import 'package:app_agendamento/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/di.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: IntroBasePage(
              title: 'App em manutenção',
              body:
                  'Nosso App está passando por melhorias. Acompanhe nossas redes sociais para receber novidades.',
              imagePath: 'assets/intro/maintenance.svg',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: SvgPicture.asset('assets/social/x.svg'),
                    onTap: () => getIt<AppExternalLauncher>().launchUrl('https://x.com'),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: SvgPicture.asset('assets/social/instagram.svg'),
                    onTap: () => getIt<AppExternalLauncher>().launchUrl('https://instagram.com'),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: SvgPicture.asset('assets/social/facebook.svg'),
                    onTap: () => getIt<AppExternalLauncher>().launchUrl('https://facebook.com'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
