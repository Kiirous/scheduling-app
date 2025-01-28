import 'package:app_agendamento/features/intro/pages/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/intro/pages/splash/splash_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      builder: (BuildContext context, GoRouterState state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (BuildContext context, GoRouterState state) => const OnboardingPage(),
    ),
  ],
);

class AppRoutes {

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static String productDetails(String id) => '/products/$id';

}