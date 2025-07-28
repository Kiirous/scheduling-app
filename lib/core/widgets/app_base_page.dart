import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_theme.dart';
import 'app_icon_button.dart';

class AppBasePage extends StatefulWidget {
  const AppBasePage({
    super.key,
    required this.title,
    required this.body,
    this.bodyPadding = const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    this.isLoading = false,
  });

  final String title;
  final Widget body;
  final EdgeInsets bodyPadding;
  final bool isLoading;

  @override
  State<AppBasePage> createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 3,
    );
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top:
                    MediaQuery.paddingOf(context).top +
                    64 +
                    widget.bodyPadding.top,
                bottom:
                    MediaQuery.paddingOf(context).bottom +
                    widget.bodyPadding.bottom,
                left: widget.bodyPadding.left,
                right: widget.bodyPadding.right,
              ),
              child: widget.body,
            ),
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
                        child: widget.isLoading ? LoadingAnimationWidget.stretchedDots(
                          color: t.primary,
                          size: 60,
                        ) : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(36),
                  ),
                ),
                margin: EdgeInsets.zero,
                elevation: 4,
                shadowColor: t.lightGray,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIconButton(
                          iconPath: 'assets/icons/chevron_left.svg',
                          onPressed: context.pop,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: t.body16Bold,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                ),
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
