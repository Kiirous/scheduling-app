import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/core/widgets/app_elevated_button.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_cubit.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/widgets/schedule_service_time_selector.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/widgets/schedule_services_day_selector.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/widgets/schedule_services_month_selector.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/widgets/schedule_services_services_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServicesPage extends StatefulWidget {
  const ScheduleServicesPage({super.key, required this.id});

  final String id;

  @override
  State<ScheduleServicesPage> createState() => _ScheduleServicesPageState();
}

class _ScheduleServicesPageState extends State<ScheduleServicesPage> {

  late final cubit = ScheduleServicesCubit(professionalId: widget.id);

  @override
  void initState() {
    super.initState();

    cubit.getProfessional();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ScheduleServicesCubit, ScheduleServicesState>(
        builder: (context, state) {
          return AppBasePage(
            isLoading: state.loading,
            backgroundColor: theme.bg,
            title: 'Agendar',
            bottomAction: AppElevatedButton(label: 'Agendar', id: 'agendar', onPressed: () {}),
            bodyPadding: EdgeInsets.zero,
            body: state.professional != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScheduleServicesServicesSelector(),
                const SizedBox(height: 16),
                const ScheduleServicesMonthSelector(),
                const SizedBox(height: 24),
                BlocBuilder<ScheduleServicesCubit, ScheduleServicesState>(
                  builder: (context, state) {
                    final cubit = context.read<ScheduleServicesCubit>();

                    if(state.selectedServices.isEmpty) return Container();

                    return ScheduleServicesDaySelector(
                      currentMonth: state.selectedMonth,
                      lastDay: state.lastAvailableDay,
                      onMonthChanged: cubit.changeSelectedMonth,
                      onRangeChanged: cubit.onRangeChanged,
                      onDaySelected: cubit.onDayChanged,
                      daySlots: state.daySlots,
                    );
                  },
                ),
                const SizedBox(height: 24),
                const ScheduleServiceTimeSelector(),
              ],
            ) : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
