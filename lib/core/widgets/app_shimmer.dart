import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends AppStateless {
  const AppShimmer({super.key, this.width, this.child});

  final double? width;
  final Widget? child;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Shimmer.fromColors(
      baseColor: theme.bg,
      highlightColor: theme.gray.withValues(alpha: 0.1),
      child: child ?? Container(
        width: width,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
