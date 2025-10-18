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
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    final w = (MediaQuery.sizeOf(context).width - (5 * 48)) / 6;
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
      bottomNavigationBar: Container(
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 78,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
                    color: t.red,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 5; i++)
                        GestureDetector(
                          onTap: () => setState(() => page = i),
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: t.secondary.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  top: 20,
                  left: w * (page + 1) + page * 48,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: t.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
