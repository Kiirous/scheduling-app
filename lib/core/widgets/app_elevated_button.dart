import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

class AppElevatedButton extends AppStateless {
  const AppElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.iconPath,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? iconPath;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return theme.gray;
          }

          return theme.primary;
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        minimumSize: WidgetStateProperty.all(const Size(128, 64)),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        foregroundColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.disabled)) {
            return theme.lightGray;
          }

          return theme.white;
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      child: Row(
        children: [
          if (iconPath != null) const SizedBox(width: 20),
          Expanded(child: Center(child: Text(label))),
          if (iconPath != null) SvgPicture.asset(iconPath!, width: 20),
        ],
      ),
    );
  }
}
