import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/di.dart';

import 'alert_area_cubit.dart';
import 'alert_widget.dart';

class AlertArea extends StatefulWidget {
  const AlertArea({super.key});

  @override
  State<AlertArea> createState() => _AlertAreaState();
}

class _AlertAreaState extends State<AlertArea> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AlertAreaCubit>(),
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AlertAreaCubit, AlertAreaState>(
              builder: (context, state) {
                return Column(
                  children: [
                    for (final alert in state.alerts) ...[
                      AlertWidget(alert: alert),
                      if(state.alerts.indexOf(alert) < state.alerts.length - 1)
                        const SizedBox(height: 8),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
