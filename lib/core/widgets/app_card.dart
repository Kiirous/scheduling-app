import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';

class AppCard extends AppStateless {
  const AppCard({
    super.key,
    this.onPressed,
    required this.child,
    this.width,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(6, 12),
            blurRadius: 15,
            spreadRadius: 0,
            color: theme.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Material(
        color: theme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          highlightColor: theme.primary.withValues(alpha: 0.1),
          splashColor: theme.primary.withValues(alpha: 0.1),
          child: Padding(padding: const EdgeInsets.all(20), child: child),
        ),
      ),
    );
  }
}
