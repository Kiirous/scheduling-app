import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfessionalBasicInfoArea extends AppStateless {
  const ProfessionalBasicInfoArea({super.key, required this.professional});

  final Professional professional;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.primary.withValues(alpha: 0.1),
            image: professional.picture != null
                ? DecorationImage(image: NetworkImage(professional.picture!), fit: BoxFit.cover)
                : null,
          ),
          child: professional.picture != null ? null : Icon(Icons.person_outline, color: theme.primary),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(professional.name, style: theme.body16Bold),
              const SizedBox(height: 4),
              Row(
                children: [
                  Padding(padding: const EdgeInsets.only(bottom: 2), child: SvgPicture.asset('assets/icons/star.svg')),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${professional.rating.toStringAsFixed(1)} (${professional.ratingCount})',
                      style: theme.label11Bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('CRM: ${professional.crm}', style: theme.label11),
            ],
          ),
        ),
      ],
    );
  }
}
