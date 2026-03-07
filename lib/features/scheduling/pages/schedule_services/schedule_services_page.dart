import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_check_box.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/core/widgets/app_elevated_button.dart';
import 'package:app_agendamento/core/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServicesPage extends StatefulWidget {
  const ScheduleServicesPage({super.key, required this.id});

  final String id;

  @override
  State<ScheduleServicesPage> createState() => _ScheduleServicesPageState();
}

class _ScheduleServicesPageState extends State<ScheduleServicesPage> {
  int day = 3;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return AppBasePage(
      backgroundColor: theme.bg,
      title: 'Agendar',
      bottomAction: AppElevatedButton(label: 'Agendar', id: 'agendar', onPressed: () {}),
      bodyPadding: EdgeInsets.zero,
      body: Column(
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (_, i) => AppCard(
              color: theme.bg,
              shadowEnabled: false,
              onPressed: () {},
              padding: const EdgeInsets.fromLTRB(10, 8, 20, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppCheckBox(checked: true, onTap: () {}),
                  const SizedBox(width: 10),
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
            ),
            itemCount: 3,
          ),
          const SizedBox(height: 16),
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
          Row(
            children: [
              const SizedBox(width: 20),
              AppChip(
                text: 'Junho',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              AppChip(
                text: 'Julho',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              AppChip(
                text: 'Agosto',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                AppIconButton(
                  id: 'mes-anterior',
                  size: 40,
                  iconPath: 'assets/icons/chevron_left.svg',
                  onPressed: () {},
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: PageView(
                      children: [
                        LayoutBuilder(
                          builder: (_, constraints) {
                            final width = constraints.maxWidth;
                            final itemWidth = width / 7;

                            return Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: itemWidth * (day - 1),
                                  child: Container(
                                    width: itemWidth,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: theme.primary,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    for (int i = 1; i < 8; i++)
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => setState(() => day = i),
                                          borderRadius: BorderRadius.circular(14),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '0$i',
                                                style: theme.heading20Bold.copyWith(
                                                  color: day == i ? theme.bg : theme.black,
                                                ),
                                              ),
                                              Text(
                                                'qui',
                                                style: theme.body13.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: day == i ? theme.bg : theme.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                AppIconButton(
                  id: 'mes-anterior',
                  size: 40,
                  iconPath: 'assets/icons/chevron_right.svg',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                for (int i = 0; i < 10; i++)
                  AppChip(
                    text: 'Junho',
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: theme.body16.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
