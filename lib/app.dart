import 'package:app_agendamento/core/flavor/flavor_config.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/alert/alert_area.dart';
import 'firebase_options.dart';

import 'core/di/di.dart';
import 'core/route/app_routes.dart';

Future<void> bootstrap(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies(config);

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
    return RepositoryProvider(
      create: (_) => AppTheme(),
      child: MaterialApp.router(
        locale: DevicePreview.locale(context),
        builder: (context, child) {
          final newChild = Stack(
            children: [
              if(child != null) child,
              const AlertArea(),
            ],
          );

          return DevicePreview.appBuilder(context, newChild);
        },
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData.light().copyWith(
          colorScheme: ThemeData.light().colorScheme.copyWith(
                surface: Colors.white,
              ),
        ),
      ),
    );
  }
}
