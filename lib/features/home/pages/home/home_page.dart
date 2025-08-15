import 'package:app_agendamento/features/home/pages/home/sections/home_header_section.dart';
import 'package:app_agendamento/features/home/pages/home/sections/home_next_schedule_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeHeaderSection(),
          Expanded(
            child: ListView(children: const [HomeNextScheduleSection()]),
          ),
        ],
      ),
    );
  }
}
