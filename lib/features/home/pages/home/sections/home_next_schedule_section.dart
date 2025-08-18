import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/features/home/pages/home/widgets/home_next_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNextScheduleSection extends StatelessWidget {
  const HomeNextScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text('Próximos agendamentos', style: t.body16Bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120 + 24,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, i) => const SizedBox(width: 16),
            itemBuilder: (_, i) => const HomeNextScheduleItem(),
          ),
        ),
      ],
    );
  }
}
