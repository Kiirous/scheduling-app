import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/features/intro/pages/onboarding/onboarding_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/device/app_device_settings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/widgets/app_alert_dialog.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../widgets/intro_base_page.dart';
import 'onboarding_page_actions.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    implements OnboardingPageActions {
  final PageController pageController = PageController();
  late final OnboardingPageCubit cubit = OnboardingPageCubit(this);

  int page = 0;

  @override
  void initState() {
    super.initState();
    cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
          builder: (context, state) {
            final pages = [
              OnboardingPageInfo(
                  title: 'Seja bem vindo(a)!',
                  body:
                      'Você poderá encontrar profissionais em sua região e agendar uma consulta com poucos cliques.',
                  imagePath: 'assets/intro/onboarding_2.svg',
                  nextButtonLabel: 'Bora lá!'),
              if (state.showLocationPage)
                OnboardingPageInfo(
                  title: 'Acesso à\nlocalização',
                  body:
                      'Para facilitar a busca de profissionais em sua região',
                  imagePath: 'assets/intro/onboarding_0.svg',
                  onNextPressed: cubit.requestLocationPermission,
                ),
              if (state.showNotificationPage)
                OnboardingPageInfo(
                  title: 'Ative às\nnotificações',
                  body:
                      'Para receber avisos importantes sobre os seus agendamentos.',
                  imagePath: 'assets/intro/onboarding_1.svg',
                  onNextPressed: cubit.requestNotificationPermission,
                ),
              OnboardingPageInfo(
                title: 'Agende uma\nconsulta',
                body:
                    'Você poderá encontrar profissionais em sua região e agendar uma consulta com poucos cliques.',
                imagePath: 'assets/intro/onboarding_2.svg',
                onNextPressed: cubit.finish,
                nextButtonLabel: 'Finalizar',
              ),
            ];

            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (final p in pages)
                        IntroBasePage(
                          title: p.title,
                          body: p.body,
                          imagePath: p.imagePath,
                        ),
                    ],
                    onPageChanged: (p) => setState(() {
                      page = p;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: [
                      if (page > 0) ...[
                        AppTextButton(
                          label: 'Voltar',
                          onPressed: () {
                            pageController.animateToPage(
                              page - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: AppElevatedButton(
                          label: pages[page].nextButtonLabel ?? 'Próximo',
                          iconPath: 'assets/icons/arrow_right.svg',
                          onPressed: () async {
                            await pages[page].onNextPressed?.call();
                            pageController.animateToPage(
                              page + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Future<void> showDeniedForeverDialog() {
    return showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        title: 'Autorização\nnegada',
        body:
            'Você não autorizou esta permissão. Acesse as configurações do seu dispositivo para permitir.',
        actions: [
          AppOutLinedButton(
            label: 'Prosseguir mesmo assim',
            onPressed: () => Navigator.pop(context),
          ),
          AppElevatedButton(
            label: 'Ir para as configurações',
            onPressed: () async {
              await getIt<AppDeviceSettings>().openSettings();
              if (mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    cubit.close();
    pageController.dispose();
    super.dispose();
  }

  @override
  void navToAuth() {
    context.go(AppRoutes.auth);
  }
}

class OnboardingPageInfo {
  OnboardingPageInfo({
    required this.title,
    required this.body,
    required this.imagePath,
    this.onNextPressed,
    this.nextButtonLabel,
  });

  final String title;
  final String body;
  final String imagePath;
  final Function? onNextPressed;
  final String? nextButtonLabel;
}
