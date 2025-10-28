import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';

class NotificationsSwitch extends AppStateless {
  const NotificationsSwitch({super.key, required this.showRead, required this.onChanged});

  final bool showRead;
  final Function(bool) onChanged;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: theme.lightGray),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Stack(
            children: [
              AnimatedAlign(
                alignment: showRead ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: constraints.maxWidth / 2,
                  decoration: BoxDecoration(
                    color: theme.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primary.withValues(alpha: 0.1),
                        blurRadius: 40,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onChanged(false);
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          'Não lidas',
                          style: theme.body13Bold.copyWith(color: showRead ? theme.gray : theme.black),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onChanged(true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          'Lidas',
                          style: theme.body16Bold.copyWith(color: !showRead ? theme.gray : theme.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
