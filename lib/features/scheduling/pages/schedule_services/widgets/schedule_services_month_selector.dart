import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServicesMonthSelector extends AppStateless {
  const ScheduleServicesMonthSelector({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocBuilder<ScheduleServicesCubit, ScheduleServicesState>(
      builder: (context, state) {
        return SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.availableMonths.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (_, i) {
              return AppChip(
                text: '${state.availableMonths[i]}',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
          ),
        );
      },
    );
  }
}
