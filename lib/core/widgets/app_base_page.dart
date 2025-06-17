import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import 'app_icon_button.dart';

class AppBasePage extends StatelessWidget {
  const AppBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(36),
                ),
              ),
              margin: EdgeInsets.zero,
              elevation: 8,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIconButton(
                        iconPath: 'assets/icons/chevron_left.svg',
                        onPressed: context.pop,
                      ),
                      Expanded(
                        child: Text(
                          'Cadastre-se',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: t.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
