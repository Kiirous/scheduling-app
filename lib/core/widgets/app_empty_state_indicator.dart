import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

class AppEmptyStateIndicator extends AppStateless {
  const AppEmptyStateIndicator({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: theme.primary),
        const SizedBox(height: 16),
        Text(message, style: theme.body16Bold),
      ],
    );
  }
}
