import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServicesPage extends StatefulWidget {
  const ScheduleServicesPage({super.key, required this.id});

  final String id;

  @override
  State<ScheduleServicesPage> createState() => _ScheduleServicesPageState();
}

class _ScheduleServicesPageState extends State<ScheduleServicesPage> {
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return AppBasePage(
      backgroundColor: theme.lightGray,
      type: AppBasePageType.fixed,
      title: 'Agendar',
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppCard(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Serviços', style: theme.heading18Bold),
                  Text('Selecione um ou mais serviços para avançar', style: theme.body13),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                          decoration: BoxDecoration(color: theme.primary, shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Exame $i', style: theme.body16Bold, textAlign: TextAlign.start),
                              Row(
                                children: [
                                  Expanded(child: Text('Duração: 30 min', style: theme.body16)),
                                  Text('R\$ 100,00', style: theme.heading18Bold),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemCount: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
