import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/features/scheduling/models/scheduling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeNextScheduleItem extends StatelessWidget {
  const HomeNextScheduleItem({super.key, required this.scheduling});

  final Scheduling scheduling;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return AppCard(
      onPressed: () {
        context.push(AppRoutes.professionalDetails(id: scheduling.professional.id));
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: t.lightGray,
                  ),
                  child: Text(
                    DateFormat('dd MMM HH:mm').format(scheduling.startDate),
                    style: t.label11Bold.copyWith(color: t.primary),
                  ),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        scheduling.services.map((s) => s.name).join(' | '),
                        style: t.body16Bold),
                  ),
                ),
                Text(
                  scheduling.professional.name,
                  style: t.body13Bold.copyWith(color: t.gray),
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: t.primary.withValues(alpha: 0.18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset('assets/icons/map_pin.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
