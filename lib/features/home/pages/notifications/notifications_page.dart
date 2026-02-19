import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_elevated_button.dart';
import 'package:app_agendamento/core/widgets/app_session_observer.dart';
import 'package:app_agendamento/core/widgets/app_simple_header.dart';
import 'package:app_agendamento/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:app_agendamento/features/home/pages/notifications/widgets/notifications_list_area.dart';
import 'package:app_agendamento/features/home/pages/notifications/widgets/notifications_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final AppTheme theme = context.watch();
    return Column(
      children: [
        const AppSimpleHeader(title: 'Notificações'),
        Expanded(
          child: AppSessionObserver(
            listener: (state) {},
            builder: (_, state) {
              if (state.loggedUser != null) {
                return Column(
                  children: [
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

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_outlined, size: 80, color: theme.primary),
                  const SizedBox(height: 16),
                  Text('Entre para ver suas notificações!', style: theme.body16Bold),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: AppElevatedButton(
                      id: 'entrar',
                      label: 'Entrar',
                      onPressed: () {
                        final uri = Uri(
                          path: AppRoutes.login.fullPath,
                          queryParameters: {'redirectTo': '${AppRoutes.home}?initialTab=notifications'},
                        );
                        context.go(uri.toString());
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
