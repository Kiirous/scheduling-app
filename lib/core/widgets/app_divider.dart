import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/app_theme.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Row(
      children: [
        Expanded(child: Divider(color: t.gray)),
        if (text != null)
          Expanded(
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: t.black,
              ),
            ),
          ),
        Expanded(child: Divider(color: t.gray)),
      ],
    );
  }
}
