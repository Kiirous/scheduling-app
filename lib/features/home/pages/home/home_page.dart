import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/features/home/pages/home/sections/home_header_section.dart';
import 'package:app_agendamento/features/home/pages/home/sections/next_schedules/home_next_schedule_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const HomeHeaderSection(),
              Expanded(child: ListView(children: const [HomeNextScheduleSection()])),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
              color: t.red,
            ),
          ),
        ],
      ),
    );
  }
}
