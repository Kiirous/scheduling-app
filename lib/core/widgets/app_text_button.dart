import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';

class AppTextButton extends AppStateless {
  const AppTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return theme.lightGray;
          }

          return color ?? theme.black;
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        minimumSize: WidgetStateProperty.all(const Size(64, 64)),
        overlayColor: WidgetStateProperty.all(theme.lightGray),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
