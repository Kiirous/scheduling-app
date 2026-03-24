import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/professional/widgets/professional_basic_info_area.dart';
import 'package:flutter/material.dart';

class ProfessionalBasicDetailsWidget extends AppStateless {
  const ProfessionalBasicDetailsWidget({super.key, required this.professional});

  final ProfessionalDetails professional;

  @override
  Widget builder(BuildContext context, AppTheme t) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfessionalBasicInfoArea(professional: professional),
          const SizedBox(height: 20),
          Text('Especialidades', style: t.body13Bold),
          const SizedBox(height: 10),
          Text(professional.specialties.map((e) => e.name).join(' | '), style: t.body16),
          const SizedBox(height: 20),
          Text('Convênios', style: t.body13Bold),
          const SizedBox(height: 10),
          Text(professional.insurances.map((e) => e.name).join(' | '), style: t.body16),
        ],
      ),
    );
  }
}
