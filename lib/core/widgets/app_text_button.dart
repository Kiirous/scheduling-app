import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return t.lightGray;
          }

          return t.black;
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
        overlayColor: WidgetStateProperty.all(t.lightGray),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
