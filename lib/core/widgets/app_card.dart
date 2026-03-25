import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

class AppCard extends AppStateless {
  const AppCard({
    super.key,
    this.onPressed,
    required this.child,
    this.width,
    this.shadowOffset = const Offset(6, 12),
    this.borderRadius,
    this.padding = const EdgeInsets.all(20),
    this.shadowEnabled = true,
    this.color,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final Offset shadowOffset;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final bool shadowEnabled;
  final Color? color;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: shadowEnabled ? shadowOffset.dy * 2 : 0),
      decoration: BoxDecoration(
        boxShadow: [
          if (shadowEnabled)
            BoxShadow(
              offset: shadowOffset,
              blurRadius: 15,
              spreadRadius: 0,
              color: theme.black.withValues(alpha: 0.08),
            ),
        ],
      ),
      child: Material(
        color: color ?? theme.white,
        shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(18)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          highlightColor: theme.primary.withValues(alpha: 0.1),
          splashColor: theme.primary.withValues(alpha: 0.1),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
