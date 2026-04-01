import 'package:app_agendamento/features/home/pages/home/sections/home_header_section.dart';
import 'package:app_agendamento/features/home/pages/home/sections/home_map/home_map_section.dart';
import 'package:flutter/material.dart';

import 'sections/next_schedules/home_next_schedule_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        const HomeHeaderSection(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              HomeNextScheduleSection(),
              SizedBox(height: 16),
              HomeMapSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
