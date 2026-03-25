import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_check_box.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_cubit.dart';
import 'package:app_agendamento/features/scheduling/widgets/services_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServicesServicesSelector extends AppStateless {
  const ScheduleServicesServicesSelector({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocBuilder<ScheduleServicesCubit, ScheduleServicesState>(
      builder: (context, state) {
        final cubit = context.read<ScheduleServicesCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Serviços', style: theme.heading18Bold),
                  Text('Selecione um ou mais serviços para avançar', style: theme.body13),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              itemCount: state.professional!.services.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) {
                final service = state.professional!.services[i];

                return AppCard(
                  color: theme.bg,
                  shadowEnabled: false,
                  onPressed: () => cubit.toggleService(service),
                  padding: const EdgeInsets.fromLTRB(10, 8, 20, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppCheckBox(
                        checked: state.selectedServices.contains(service),
                        onTap: () => cubit.toggleService(service),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ServicesDetailItem(service: service),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
