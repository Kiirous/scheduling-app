import 'package:app_agendamento/core/firebase/analytics/custom_firebase_analytics_observer.dart';
import 'package:app_agendamento/core/route/custom_page_route.dart';
import 'package:app_agendamento/features/auth/data/session/session_cubit.dart';
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
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final protectedRoutes = [RegExp(r"\/professionals\/.*\/schedule-services")];

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final currentLocation = state.uri.toString();
    if (protectedRoutes.any((route) => route.hasMatch(currentLocation))) {
      final SessionCubit sessionCubit = context.read();

      if (sessionCubit.state.loggedUser == null) {
        final uri = Uri(path: AppRoutes.login.fullPath, queryParameters: {'redirectTo': currentLocation});
        return uri.toString();
      }
    }
    return null;
  },
  observers: [CustomFirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  errorPageBuilder: (context, state) => CustomPage(state: state, child: const NotFoundPage()),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => CustomPage(state: state, child: const SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) => CustomPage(state: state, child: const OnboardingPage()),
    ),
    GoRoute(
      path: AppRoutes.auth,
      pageBuilder: (context, state) => CustomPage(state: state, child: const AuthPage()),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.signUp.path,
          pageBuilder: (context, state) => CustomPage(state: state, child: const SignUpPage()),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          pageBuilder: (context, state) => CustomPage(
            state: state,
            child: LoginPage(redirectTo: state.uri.queryParameters['redirectTo']),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.maintenance,
      pageBuilder: (context, state) => CustomPage(state: state, child: const MaintenancePage()),
    ),
    GoRoute(
      path: AppRoutes.forceUpdate,
      pageBuilder: (context, state) => CustomPage(state: state, child: const ForceUpdatePage()),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => CustomPage(
        state: state,
        child: BasePage(initialTab: state.pathParameters['initialTab']),
      ),
      routes: [
        GoRoute(
          path: AppRoutes.professionalDetails.path,
          pageBuilder: (context, state) => CustomPage(
            state: state,
            child: ProfessionalDetailsPage(id: state.pathParameters['id']!),
          ),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.professionalRatings.path,
              pageBuilder: (context, state) => CustomPage(
                state: state,
                child: ProfessionalRatingsPage(id: state.pathParameters['id']!),
              ),
            ),
            GoRoute(
              path: AppRoutes.professionalScheduleServices.path,
              pageBuilder: (context, state) => CustomPage(
                state: state,
                child: ScheduleServicesPage(id: state.pathParameters['id']!),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/intro';
  static const String auth = '/auth';
  static const String maintenance = '/maintenance';
  static const String forceUpdate = '/force-update';
  static const String home = '/';

  static AppRouteWithId professionalDetails = AppRouteWithId(
    path: 'professionals/:id',
    buildFullPath: (String id) => '/professionals/$id',
  );

  static const AppRoute signUp = AppRoute(fullPath: '/auth/signup', path: 'signup');
  static const AppRoute login = AppRoute(fullPath: '/auth/login', path: 'login');

  static AppRouteWithId professionalRatings = AppRouteWithId(
    path: 'ratings',
    buildFullPath: (String id) => '/professionals/$id/ratings',
  );

  static AppRouteWithId professionalScheduleServices = AppRouteWithId(
    path: 'schedule-services',
    buildFullPath: (String id) => '/professionals/$id/schedule-services',
  );
}

class AppRoute {
  const AppRoute({required this.fullPath, required this.path});

  final String fullPath;
  final String path;
}

class AppRouteWithId {
  const AppRouteWithId({required this.path, required Function(String id) buildFullPath})
    : _buildFullPath = buildFullPath;

  final String path;
  final Function(String id) _buildFullPath;

  String fullPath({required String id}) => _buildFullPath(id);
}
