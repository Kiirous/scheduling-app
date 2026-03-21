import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_session_observer.dart';
import 'package:app_agendamento/core/widgets/app_shimmer.dart';
import 'package:app_agendamento/features/home/pages/home/sections/next_schedules/home_next_schedules_cubit.dart';
import 'package:app_agendamento/features/home/pages/home/sections/next_schedules/widgets/home_next_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNextScheduleSection extends StatefulWidget {
  const HomeNextScheduleSection({super.key});

  @override
  State<HomeNextScheduleSection> createState() => _HomeNextScheduleSectionState();
}

class _HomeNextScheduleSectionState extends State<HomeNextScheduleSection> {
  final HomeNextSchedulesCubit cubit = HomeNextSchedulesCubit();

  void loadingSchedulings(bool isLoggedIn) {
    if (isLoggedIn) {
      cubit.loadSchedulings();
    } else {
      cubit.setUserNotLoggedIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return AppSessionObserver(
      listener: (sessionState) => loadingSchedulings(sessionState.loggedUser != null),
      child: BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
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
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: OverflowBox(
                          maxWidth: 1000,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const SizedBox(width: 24),
                              AppCard(width: 270, child: Container()),
                              const SizedBox(width: 16),
                              AppCard(width: 270, child: Container()),
                            ],
                          ),
                        ),
                      ),
                      HomeNextSchedulesStatus.notLoggedIn => Container(color: Colors.blue),
                      HomeNextSchedulesStatus.error => Container(color: Colors.red),
                      HomeNextSchedulesStatus.success => ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.schedulings!.length,
                        separatorBuilder: (_, i) => const SizedBox(width: 16),
                        itemBuilder: (_, i) => SizedBox(
                          width: state.schedulings!.length == 1 ? MediaQuery.sizeOf(context).width - 48 : 270,
                          child: HomeNextScheduleItem(scheduling: state.schedulings![i], shadowOffset: const Offset(6, 12)),
                        ),
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
