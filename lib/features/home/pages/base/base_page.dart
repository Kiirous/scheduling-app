import 'package:app_agendamento/features/home/pages/base/widgets/bottom_nav_bar.dart';
import 'package:app_agendamento/features/home/pages/home/home_page.dart';
import 'package:app_agendamento/features/home/pages/notifications/notifications_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int page = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
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
          const HomePage(),
          Container(color: Colors.red),
          Container(color: Colors.grey),
          const NotificationsPage(),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}
