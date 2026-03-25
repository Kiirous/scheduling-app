import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeNextScheduleItem extends StatelessWidget {
  const HomeNextScheduleItem({super.key, required this.scheduling, required this.shadowOffset});

  final Scheduling scheduling;
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return AppCard(
      onPressed: () {
        context.push(AppRoutes.schedulingDetails.fullPath(id: scheduling.id));
      },
      shadowOffset: shadowOffset,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppChip(text: DateFormat('dd MMM HH:mm').format(scheduling.startDate)),
                    const Spacer(),
                    if (scheduling.status == SchedulingStatus.canceled)
                      AppChip(
                        text: 'Cancelado',
                        color: theme.error,
                        textStyle: theme.label11Bold.copyWith(color: theme.red),
                      ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(scheduling.services.map((s) => s.name).join(' | '), style: theme.body16Bold),
                  ),
                ),
                Text(scheduling.professional.name, style: theme.body13Bold.copyWith(color: theme.gray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
