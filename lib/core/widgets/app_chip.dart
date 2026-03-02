import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';

class AppChip extends AppStateless {
  const AppChip({
    super.key,
    required this.text,
    this.minWidth,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  final String text;
  final double? minWidth;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      constraints: minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
      padding: padding,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: theme.lightGray),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ?? theme.label11Bold.copyWith(color: theme.primary),
      ),
    );
  }
}
