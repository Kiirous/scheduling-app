import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/features/professional/pages/professional_details/professional_details_page_cubit.dart';
import 'package:flutter/material.dart';

class ProfessionalDetailsPage extends StatefulWidget {
  const ProfessionalDetailsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {

  final ProfessionalDetailsPageCubit cubit = ProfessionalDetailsPageCubit();


  @override
  void initState() {
    super.initState();
    cubit.getProfessional(widget.id);
  }

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
