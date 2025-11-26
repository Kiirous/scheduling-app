import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSimpleHeader extends StatelessWidget {
  const AppSimpleHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: t.heading20Bold),
        ),
      ),
    );
  }
}
