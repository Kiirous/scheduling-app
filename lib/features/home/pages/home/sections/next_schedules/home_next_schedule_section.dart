import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_shimmer.dart';
import 'package:app_agendamento/features/home/pages/home/sections/next_schedules/home_next_schedules_cubit.dart';
import 'package:app_agendamento/features/home/pages/home/sections/next_schedules/widgets/home_next_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNextScheduleSection extends StatefulWidget {
  const HomeNextScheduleSection({super.key});

  @override
  State<HomeNextScheduleSection> createState() =>
      _HomeNextScheduleSectionState();
}

class _HomeNextScheduleSectionState extends State<HomeNextScheduleSection> {
  final HomeNextSchedulesCubit cubit = HomeNextSchedulesCubit();

  @override
  void initState() {
    super.initState();
    cubit.loadSchedulings();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return BlocProvider.value(
      value: cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('Próximos agendamentos', style: t.body16Bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120 + 24,
            child: BlocBuilder<HomeNextSchedulesCubit, HomeNextSchedulesState>(
              builder: (context, state) {
                return switch (state.status) {
                  HomeNextSchedulesStatus.loading => AppShimmer(
                    child: OverflowBox(
                      maxWidth: 1000,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const SizedBox(width: 24),
                          AppCard( width: 270, child: Container()),
                          const SizedBox(width: 16),
                          AppCard(width: 270, child: Container()),
                        ],
                      ),
                    ),
                  ),
                  HomeNextSchedulesStatus.error => Container(),
                  HomeNextSchedulesStatus.success => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.schedulings!.length,
                    separatorBuilder: (_, i) => const SizedBox(width: 16),
                    itemBuilder: (_, i) => SizedBox(
                      width: state.schedulings!.length == 1
                          ? MediaQuery.sizeOf(context).width - 48
                          : 270,
                      child: const HomeNextScheduleItem(),
                    ),
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
