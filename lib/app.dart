import 'package:app_agendamento/core/flavor/flavor_config.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/utils/no_glow_behavior.dart';
import 'package:app_agendamento/features/auth/data/session/session_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/alert/alert_area.dart';
import 'firebase_options.dart';

import 'core/di/di.dart';
import 'core/route/app_routes.dart';

Future<void> bootstrap(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies(config);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    DevicePreview(
      builder: (_) => const App(),
      enabled: true, //config.flavor == AppFlavor.dev,
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppTheme();
    return RepositoryProvider.value(
      value: t,
      child: BlocProvider.value(
        value: getIt<SessionCubit>(),
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: (context, child) {
            final newChild = ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: Stack(
                children: [if (child != null) child, const AlertArea()],
              ),
            );

            return DevicePreview.appBuilder(context, newChild);
          },
          theme: ThemeData.light().copyWith(
            colorScheme: ThemeData.light().colorScheme.copyWith(
              surface: Colors.white,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: t.primary,
              selectionHandleColor: t.primary,
              selectionColor: t.primary.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
