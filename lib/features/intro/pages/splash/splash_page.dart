import 'package:app_agendamento/features/intro/pages/splash/splash_page_actions.dart';
import 'package:app_agendamento/features/intro/pages/splash/splash_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/route/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashPageActions {
  late final SplashPageCubit cubit = SplashPageCubit(this);

  Alignment logoAlignment = const Alignment(-2, -2);
  Alignment titleAlignment = const Alignment(2, 2);

  @override
  void initState() {
    super.initState();
    cubit.initialize();

    Future.delayed(Duration.zero).then((value) {
      setState(() {
        logoAlignment = const Alignment(-0.25, 0);
        titleAlignment = const Alignment(0.25, 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(seconds: 1),
              alignment: logoAlignment,
              curve: Curves.bounceOut,
              child: SvgPicture.asset('assets/brand/logo.svg'),
            ),
            AnimatedAlign(
              duration: const Duration(seconds: 1),
              alignment: titleAlignment,
              curve: Curves.bounceOut,
              child: SvgPicture.asset('assets/brand/title.svg'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void navToMaintenance() {
    context.go(AppRoutes.maintenance);
  }

  @override
  void navToOnboarding() {
    context.go('/qwerqwerqwer');
  }

  @override
  void navToAuth() {
    context.go('/qwer');
  }

  @override
  void navToHome() {
    context.go(AppRoutes.home);
  }

  @override
  void navToForceUpdate() {
    context.go(AppRoutes.forceUpdate);
  }

  @override
  void dispose() {
    cubit.dispose();
    cubit.close();
    super.dispose();
  }
}
