import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:flutter/material.dart';

class ProfessionalDetailsPage extends StatefulWidget {
  const ProfessionalDetailsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AppBasePage(
      title: 'PROFESSIONAL',
      body: Column(
        children: [],
      ),
    );
  }
}
