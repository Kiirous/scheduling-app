import 'package:app_agendamento/core/widgets/app_loading_indicator.dart';
import 'package:app_agendamento/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:app_agendamento/features/home/pages/notifications/widgets/notification_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<NotificationsPageCubit, NotificationsPageState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: AppLoadingIndicator());
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              padding: MediaQuery.paddingOf(context).add(const EdgeInsets.fromLTRB(24, 0, 24, 24)),
              itemCount: state.notifications!.length + (state.finishedLoading ? 0 : 1),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                if (i < state.notifications!.length) {
                  return NotificationListItem(notification: state.notifications![i]);
                } else {
                  _cubit.loadNotifications();
                  return const Center(child: AppLoadingIndicator());
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
