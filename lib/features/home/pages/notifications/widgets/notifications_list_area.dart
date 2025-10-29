import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationsListArea extends StatefulWidget {
  const NotificationsListArea({super.key, required this.status});

  final NotificationStatus status;

  @override
  State<NotificationsListArea> createState() => _NotificationsListAreaState();
}

class _NotificationsListAreaState extends State<NotificationsListArea> with AutomaticKeepAliveClientMixin {
  late final NotificationsPageCubit _cubit = NotificationsPageCubit(status: widget.status);

  @override
  void initState() {
    super.initState();
    _cubit.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppTheme t = context.watch();
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<NotificationsPageCubit, NotificationsPageState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: LoadingAnimationWidget.stretchedDots(color: t.primary, size: 40));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              padding: MediaQuery.paddingOf(context).add(const EdgeInsets.fromLTRB(24, 0, 24, 24)),
              itemCount: state.notifications!.length + (state.finishedLoading ? 0 : 1),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                if (i < state.notifications!.length) {
                  final notification = state.notifications![i];
                  return AppCard(
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: t.primary),
                          child: Icon(Icons.notifications_outlined, color: t.white),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [Expanded(child: Text(notification.title, style: t.body16Bold))],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notification.subtitle,
                                style: t.body13,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  _cubit.loadNotifications();
                  return Center(child: LoadingAnimationWidget.stretchedDots(color: t.primary, size: 40));
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
