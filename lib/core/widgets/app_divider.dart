import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppDivider extends AppStateless {
  const AppDivider({super.key, this.text});

  final String? text;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Row(
      children: [
        Expanded(child: Divider(color: theme.gray)),
        if (text != null)
          Expanded(
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: theme.black,
              ),
            ),
          ),
        Expanded(child: Divider(color: theme.gray)),
      ],
    );
  }
}
