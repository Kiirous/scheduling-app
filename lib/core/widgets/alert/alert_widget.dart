import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import '../../theme/app_theme.dart';
import 'alert_area_cubit.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({super.key, required this.alert});

  final Alert alert;

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.alert.duration).then((value) => _controller.reverse());
      } else if (status == AnimationStatus.dismissed) {
        getIt<AlertAreaCubit>().removeAlert(widget.alert);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: switch (widget.alert.type) {
                AlertType.success => t.success,
                AlertType.error => t.error,
                AlertType.notification => t.white,
              },
              boxShadow: [
                BoxShadow(
                  offset: const Offset(6, 14),
                  blurRadius: 15,
                  spreadRadius: 0,
                  color: t.black.withValues(alpha: 0.08),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: InkWell(
              onTap: () {
                widget.alert.onTap?.call();
                getIt<AlertAreaCubit>().removeAlert(widget.alert);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.alert.title, style: t.body16Bold),
                        if (widget.alert.subtitle != null) ...[
                          const SizedBox(height: 8),
                          Text(widget.alert.subtitle!, style: t.body13),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    switch (widget.alert.type) {
                      AlertType.success => Icons.check_circle_outline,
                      AlertType.error => Icons.cancel_outlined,
                      AlertType.notification => Icons.notifications,
                    },
                    color: switch (widget.alert.type) {
                      AlertType.success => t.secondary,
                      AlertType.error => t.red,
                      AlertType.notification => t.black,
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
