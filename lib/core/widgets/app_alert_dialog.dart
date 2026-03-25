import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppAlertDialog extends AppStateless {
  const AppAlertDialog({
    super.key,
    required this.title,
    required this.body,
    required this.actions,
  });

  final String title;
  final String body;
  final List<Widget> actions;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      surfaceTintColor: theme.bg,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: theme.black,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: theme.black,
              ),
            ),
            const SizedBox(height: 24),
            for(final item in actions) ...[
              item,
              if(item != actions.last) const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
