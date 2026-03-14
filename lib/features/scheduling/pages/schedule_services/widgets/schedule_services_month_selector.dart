import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleServicesMonthSelector extends AppStateless {
  const ScheduleServicesMonthSelector({super.key});

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
                  Text('Data', style: theme.heading18Bold),
                  Text('Selecione um mês para visualizar os dias disponíveis', style: theme.body13),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.availableMonths.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (_, i) {
                  final month = state.availableMonths[i];
                  final selectedMonth = state.selectedMonth;
                  final isCurrent = month == selectedMonth;

                  return AppChip(
                    color: isCurrent ? theme.primary : theme.white,
                    text: DateFormat('MMMM').format(state.availableMonths[i]),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: theme.body16.copyWith(
                      color: isCurrent ? theme.white : theme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () => context.read<ScheduleServicesCubit>().changeSelectedMonth(month),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
              ),
            ),
          ],
        );
      },
    );
  }
}
