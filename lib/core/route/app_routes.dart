import 'package:app_agendamento/features/auth/pages/auth/auth_page.dart';
import 'package:app_agendamento/features/auth/pages/login/login_page.dart';
import 'package:app_agendamento/features/auth/pages/sign_up/sign_up_page.dart';
import 'package:app_agendamento/features/home/pages/base/base_page.dart';
import 'package:app_agendamento/features/intro/pages/force_update/force_update_page.dart';
import 'package:app_agendamento/features/intro/pages/maintenance/maintenance_page.dart';
import 'package:app_agendamento/features/intro/pages/not_found/not_found_page.dart';
import 'package:app_agendamento/features/intro/pages/onboarding/onboarding_page.dart';
import 'package:app_agendamento/features/intro/pages/splash/splash_page.dart';
import 'package:app_agendamento/features/professional/pages/professional_details/professional_details_page.dart';
import 'package:app_agendamento/features/professional/pages/professional_ratings/professional_ratings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: <RouteBase>[
    GoRoute(path: AppRoutes.splash, builder: (BuildContext context, GoRouterState state) => const SplashPage()),
    GoRoute(path: AppRoutes.onboarding, builder: (BuildContext context, GoRouterState state) => const OnboardingPage()),
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
          builder: (BuildContext context, GoRouterState state) =>
              LoginPage(redirectTo: state.uri.queryParameters['redirectTo']),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.maintenance,
      builder: (BuildContext context, GoRouterState state) => const MaintenancePage(),
    ),
    GoRoute(
      path: AppRoutes.forceUpdate,
      builder: (BuildContext context, GoRouterState state) => const ForceUpdatePage(),
    ),
    GoRoute(path: AppRoutes.home, builder: (BuildContext context, GoRouterState state) => const BasePage()),
    GoRoute(
      path: AppRoutes.professionalDetails(id: ':id'),
      builder: (BuildContext context, GoRouterState state) => ProfessionalDetailsPage(id: state.pathParameters['id']!),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.professionalRatings.path,
          builder: (BuildContext context, GoRouterState state) =>
              ProfessionalRatingsPage(id: state.pathParameters['id']!),
        ),
      ],
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

  static String professionalDetails({required String id}) => '/professionals/$id';

  static const AppRoute signUp = AppRoute(fullPath: '/auth/signup', path: 'signup');
  static const AppRoute login = AppRoute(fullPath: '/auth/login', path: 'login');

  static AppRouteWithId professionalRatings = AppRouteWithId(
    path: 'ratings',
    buildFullPath: (String id) => '/professionals/$id/ratings',
  );
}

class AppRoute {
  const AppRoute({required this.fullPath, required this.path});

  final String fullPath;
  final String path;
}

class AppRouteWithId {
  const AppRouteWithId({required this.path, required this.buildFullPath});

  final String path;
  final Function(String id) buildFullPath;

  String fullPath({required String id}) => buildFullPath(id);
}
