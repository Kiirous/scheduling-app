import 'dart:ui';

import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_theme.dart';
import 'app_icon_button.dart';

enum AppBasePageType { fixed, scrollable }

class AppBasePage extends StatefulWidget {
  const AppBasePage({
    super.key,
    required this.title,
    required this.body,
    this.bodyPadding = const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    this.isLoading = false,
    this.type = AppBasePageType.scrollable,
    this.bottomAction,
    this.backgroundColor
  });

  final String title;
  final Widget body;
  final EdgeInsets bodyPadding;
  final bool isLoading;
  final AppBasePageType type;
  final Widget? bottomAction;
  final Color? backgroundColor;

  @override
  State<AppBasePage> createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1), lowerBound: 0, upperBound: 3);
  }

  ///Sempre em um statefull widget, quando os parâmetros que são passados, mudam
  ///Esse didUpdateWidget é chamado
  @override
  void didUpdateWidget(AppBasePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isLoading && widget.isLoading) {
      controller.forward();
    } else if (oldWidget.isLoading && !widget.isLoading) {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            if (widget.type == AppBasePageType.scrollable)
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 52,
                  bottom: MediaQuery.paddingOf(context).bottom + (widget.bottomAction != null ? 88 : 0),
                ).add(widget.bodyPadding),
                child: widget.body,
              )
            else
              widget.body,
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: widget.isLoading,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    final value = controller.value;

                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                      child: Container(
                        alignment: Alignment.center,
                        child: widget.isLoading
                            ? LoadingAnimationWidget.stretchedDots(color: t.primary, size: 60)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AppCard(
                padding: EdgeInsets.zero,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIconButton(id: 'voltar', iconPath: 'assets/icons/chevron_left.svg', onPressed: context.pop),
                        Expanded(
                          child: Text(widget.title, textAlign: TextAlign.center, style: t.body16Bold),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.bottomAction != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.8),
                        Colors.white.withValues(alpha: 0.8),
                      ],
                      stops: const [0, 0.1, 1],
                    ),
                  ),
                  child: widget.bottomAction!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
