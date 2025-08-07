import 'package:app_agendamento/features/auth/pages/login/login_page.dart';
import 'package:app_agendamento/features/intro/pages/maintenance/maintenance_page.dart';
import 'package:app_agendamento/features/intro/pages/not_found/not_found_page.dart';
import 'package:app_agendamento/features/intro/pages/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/pages/auth/auth_page.dart';
import '../../features/auth/pages/sign_up/sign_up_page.dart';
import '../../features/home/pages/home/home_page.dart';
import '../../features/intro/pages/force_update/force_update_page.dart';
import '../../features/intro/pages/splash/splash_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (BuildContext context, GoRouterState state) => const AuthPage(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.signUp.path,
          builder: (BuildContext context, GoRouterState state) => const SignUpPage(),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          builder: (BuildContext context, GoRouterState state) => const LoginPage(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.maintenance,
      builder: (BuildContext context, GoRouterState state) =>
          const MaintenancePage(),
    ),
    GoRoute(
      path: AppRoutes.forceUpdate,
      builder: (BuildContext context, GoRouterState state) =>
          const ForceUpdatePage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) =>
      const HomePage(),
    ),
  ],
);

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/intro';
  static const String auth = '/auth';
  static const String maintenance = '/maintenance';
  static const String forceUpdate = '/force-update';
  static const String home = '/home';

  static const AppRoute signUp = AppRoute(
    fullPath: '/auth/signup',
    path: 'signup',
  );
  static const AppRoute login = AppRoute(
    fullPath: '/auth/login',
    path: 'login',
  );
}

class AppRoute {
  const AppRoute({required this.fullPath, required this.path});

  final String fullPath;
  final String path;
}