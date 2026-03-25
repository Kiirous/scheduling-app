import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_alert_dialog.dart';
import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/core/widgets/app_elevated_button.dart';
import 'package:app_agendamento/core/widgets/app_text_button.dart';
import 'package:app_agendamento/features/professional/widgets/professional_basic_info_area.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:app_agendamento/features/scheduling/pages/scheduling_details/scheduling_details_cubit.dart';
import 'package:app_agendamento/features/scheduling/widgets/services_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  Widget? bottomAction(Scheduling? scheduling) {
    if (scheduling == null) {
      return null;
    } else if (scheduling.status == SchedulingStatus.active && scheduling.startDate.isAfter(DateTime.now())) {
      return AppElevatedButton(
        id: 'cancelar',
        label: 'Cancelar',
        onPressed: () async {
          final cancel = await showCancelDialog();
          if (cancel != null && cancel) cubit.cancelScheduling();
        },
      );
    } else {
      return AppElevatedButton(
        id: 'novo-agendamento',
        label: 'Novo agendamento',
        onPressed: () async {
          context.pushReplacement(AppRoutes.professionalScheduleServices.fullPath(id: scheduling.professional.id));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<SchedulingDetailsCubit, SchedulingDetailsState>(
        builder: (_, state) {
          return AppBasePage(
            isLoading: state.isLoading,
            bottomAction: bottomAction(state.scheduling),
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
                            Row(
                              children: [
                                Expanded(child: Text('Detalhes', style: theme.heading18Bold)),
                                if (state.scheduling!.status == SchedulingStatus.canceled)
                                  AppChip(
                                    text: 'Agendamento cancelado',
                                    color: theme.error,
                                    textStyle: theme.body13Bold.copyWith(color: theme.red),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Data e Horário', style: theme.body13),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat('dd/MM/yyyy | HH:mm').format(state.scheduling!.startDate),
                              textAlign: TextAlign.start,
                              style: theme.body16Bold,
                            ),
                            const SizedBox(height: 16),
                            Text('Serviço${state.scheduling!.services.length > 1 ? 's' : ''}', style: theme.body13),
                            const SizedBox(height: 8),
                            for (final s in state.scheduling!.services)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.only(right: 9, top: 5),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: theme.primary),
                                    ),
                                    Expanded(child: ServicesDetailItem(service: s)),
                                  ],
                                ),
                              ),
                            Divider(color: theme.gray.withValues(alpha: 0.5)),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Total', style: theme.body16),
                                const Spacer(),
                                Text(
                                  NumberFormat.simpleCurrency(locale: 'pt-BR').format(
                                    state.scheduling!.services.fold(
                                      0.0,
                                      (previousValue, service) => previousValue + service.price,
                                    ),
                                  ),
                                  style: theme.heading20Bold,
                                ),
                              ],
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

  Future<bool?> showCancelDialog() {
    return showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        title: 'Cancelar agendamento?',
        body: 'Você deseja cancelar o agendamento?',
        actions: [
          Row(
            children: [
              Expanded(
                child: AppTextButton(id: 'nao', label: 'Não', onPressed: () => Navigator.of(context).pop(false)),
              ),
              Expanded(
                child: AppElevatedButton(id: 'sim', label: 'Sim', onPressed: () => Navigator.of(context).pop(true)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
