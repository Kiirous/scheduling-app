import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServiceTimeSelector extends AppStateless {
  const ScheduleServiceTimeSelector({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocBuilder<ScheduleServicesCubit, ScheduleServicesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Horários disponíveis', style: theme.heading18Bold),
                  Text('Selecione um horário para realizar o agendamento', style: theme.body13),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (state.daySlots != null && state.selectedDay != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    for (final slot
                        in state.daySlots!
                            .firstWhere((d) => DateUtils.dateOnly(d.date) == DateUtils.dateOnly(state.selectedDay!))
                            .slots)
                      AppChip(
                        text: 'Agosto',
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: theme.body16.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
