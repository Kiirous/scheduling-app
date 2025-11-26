import 'package:app_agendamento/core/widgets/app_simple_header.dart';
import 'package:app_agendamento/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:app_agendamento/features/home/pages/notifications/widgets/notifications_list_area.dart';
import 'package:app_agendamento/features/home/pages/notifications/widgets/notifications_switch.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with AutomaticKeepAliveClientMixin {
  bool _showRead = false;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const AppSimpleHeader(title: 'Notificações'),
        NotificationsSwitch(
          showRead: _showRead,
          onChanged: (r) {
            setState(() => _showRead = r);
            _pageController.animateToPage(
              _showRead ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              NotificationsListArea(status: NotificationStatus.notRead),
              NotificationsListArea(status: NotificationStatus.read),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
