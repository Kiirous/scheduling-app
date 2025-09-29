import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:flutter/material.dart';

class ProfessionalRatingsPage extends StatefulWidget {
  const ProfessionalRatingsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalRatingsPage> createState() => _ProfessionalRatingsPageState();
}

class _ProfessionalRatingsPageState extends State<ProfessionalRatingsPage> {
  @override
  Widget build(BuildContext context) {
    return AppBasePage(
      title: 'AVALIAÇÕES',
      isLoading: false,
      body: Column(children: []),
    );
  }
}
