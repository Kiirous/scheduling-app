import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/features/intro/pages/onboarding/onboarding_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_text_button.dart';
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
    final AppTheme t = context.watch();
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
          builder: (context, state) {
            final pages = [
              OnboardingPageInfo(
                title: 'Seja bem vindo(a)!',
                description:
                    'Você poderá encontrar profissionais em sua região e agendar uma consulta com poucos cliques.',
                imagePath: 'assets/onboarding/onboarding_2.svg',
                nextButtonLabel: 'Bora lá!'
              ),
              if (state.showLocationPage)
                OnboardingPageInfo(
                  title: 'Acesso à\nlocalização',
                  description:
                      'Para facilitar a busca de profissionais em sua região',
                  imagePath: 'assets/onboarding/onboarding_0.svg',
                  onNextPressed: cubit.requestLocationPermission,
                ),
              if (state.showNotificationPage)
                OnboardingPageInfo(
                  title: 'Ative às\nnotificações',
                  description:
                      'Para receber avisos importantes sobre os seus agendamentos.',
                  imagePath: 'assets/onboarding/onboarding_1.svg',
                  onNextPressed: cubit.requestNotificationPermission,
                ),
              OnboardingPageInfo(
                title: 'Agende uma\nconsulta',
                description:
                    'Você poderá encontrar profissionais em sua região e agendar uma consulta com poucos cliques.',
                imagePath: 'assets/onboarding/onboarding_2.svg',
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
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: SvgPicture.asset(p.imagePath)),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: Text(
                                        p.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700,
                                          color: t.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                        p.description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: t.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
      builder: (_) => const AlertDialog(
        content: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
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
    required this.description,
    required this.imagePath,
    this.onNextPressed,
    this.nextButtonLabel,
  });

  final String title;
  final String description;
  final String imagePath;
  final Function? onNextPressed;
  final String? nextButtonLabel;
}
