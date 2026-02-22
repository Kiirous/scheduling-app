import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:flutter/material.dart';

class ScheduleServicesPage extends StatefulWidget {
  const ScheduleServicesPage({super.key, required this.id});

  final String id;

  @override
  State<ScheduleServicesPage> createState() => _ScheduleServicesPageState();
}

class _ScheduleServicesPageState extends State<ScheduleServicesPage> {
  @override
  Widget build(BuildContext context) {
    return AppBasePage(title: 'Agendar', body: Container());
  }
}
