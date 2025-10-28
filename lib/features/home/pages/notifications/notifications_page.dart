import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_simple_header.dart';
import 'package:app_agendamento/features/home/pages/notifications/widgets/notifications_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with AutomaticKeepAliveClientMixin {
  bool _showRead = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppTheme t = context.watch();

    return Column(
      children: [
        const AppSimpleHeader(title: 'Notificações'),
        NotificationsSwitch(
          showRead: _showRead,
          onChanged: (value) => setState(() => _showRead = value),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                height: 48,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: t.lightGray),
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return Stack(
                      children: [
                        AnimatedAlign(
                          alignment: _showRead ? Alignment.centerRight : Alignment.centerLeft,
                          duration: const Duration(milliseconds: 250),
                          child: Container(
                            width: constraints.maxWidth / 2,
                            decoration: BoxDecoration(
                              color: t.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: t.primary.withValues(alpha: 0.1),
                                  blurRadius: 40,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showRead = false;
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Não lidas (2)',
                                    style: t.body13Bold.copyWith(color: _showRead ? t.gray : t.black),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showRead = true;
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Lidas',
                                    style: t.body16Bold.copyWith(color: !_showRead ? t.gray : t.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
