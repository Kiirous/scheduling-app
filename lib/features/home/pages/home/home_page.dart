import 'package:app_agendamento/features/home/pages/home/sections/home_header_section.dart';
import 'package:app_agendamento/features/home/pages/home/sections/next_schedules/home_next_schedule_section.dart';
import 'package:app_agendamento/features/home/pages/home/widgets/home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeBottomNavBar(
        page: page,
        onChanged: (p) {
          setState(() => page = p);
          _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Column(
            children: [
              const HomeHeaderSection(),
              Expanded(child: ListView(children: const [HomeNextScheduleSection()])),
            ],
          ),
          Container(color: Colors.red),
          Container(color: Colors.grey),
          Container(color: Colors.yellow),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}
