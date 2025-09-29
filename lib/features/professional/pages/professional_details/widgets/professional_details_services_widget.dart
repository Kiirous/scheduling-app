import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:flutter/material.dart';

class ProfessionalDetailsServicesWidget extends AppStateless {
  const ProfessionalDetailsServicesWidget({super.key, required this.professional});

  final ProfessionalDetails professional;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Serviços', style: theme.heading18Bold),
        const SizedBox(height: 10),
        for (final s in professional.services)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: theme.primary),
                ),
                const SizedBox(width: 9),
                Expanded(child: Text(s.name, style: theme.body16)),
              ],
            ),
          ),
      ],
    );
  }
}
