import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfessionalBasicDetailsWidget extends AppStateless {
  const ProfessionalBasicDetailsWidget({super.key, required this.professional});

  final ProfessionalDetails professional;

  @override
  Widget builder(BuildContext context, AppTheme t) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: t.primary.withValues(alpha: 0.1),
                  image: professional.picture != null
                      ? DecorationImage(image: NetworkImage(professional.picture!), fit: BoxFit.cover)
                      : null,
                ),
                child: professional.picture != null ? null : Icon(Icons.person_outline, color: t.primary),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(professional.name, style: t.body16Bold),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: SvgPicture.asset('assets/icons/star.svg'),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${professional.rating.toStringAsFixed(1)} (${professional.ratingCount})',
                            style: t.label11Bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('CRM: ${professional.crm}', style: t.label11),
                  ],
                ),
              ),
            ],
          ),
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
