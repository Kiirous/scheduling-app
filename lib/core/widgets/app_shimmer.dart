import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, this.width, this.child});

  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Shimmer.fromColors(
      baseColor: t.bg,
      highlightColor: t.gray.withValues(alpha: 0.1),
      child: child ?? Container(
        width: width,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
