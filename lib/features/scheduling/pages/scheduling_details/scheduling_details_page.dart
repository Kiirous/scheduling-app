import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/features/professional/widgets/professional_basic_info_area.dart';
import 'package:app_agendamento/features/scheduling/pages/scheduling_details/scheduling_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SchedulingDetailsPage extends StatefulWidget {
  const SchedulingDetailsPage({super.key, required this.schedulingId});

  final String schedulingId;

  @override
  State<SchedulingDetailsPage> createState() => _SchedulingDetailsPageState();
}

class _SchedulingDetailsPageState extends State<SchedulingDetailsPage> {
  late final SchedulingDetailsCubit cubit = SchedulingDetailsCubit(schedulingId: widget.schedulingId);

  @override
  void initState() {
    super.initState();
    cubit.loadScheduling();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<SchedulingDetailsCubit, SchedulingDetailsState>(
        builder: (_, state) {
          return AppBasePage(
            isLoading: state.isLoading,
            title: 'Agendamento',
            body: state.scheduling != null
                ? Column(
                    children: [
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ProfessionalBasicInfoArea(professional: state.scheduling!.professional),
                            const SizedBox(height: 24),
                            Text(
                              DateFormat('dd/MM/yyyy | HH:mm').format(state.scheduling!.startDate),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
