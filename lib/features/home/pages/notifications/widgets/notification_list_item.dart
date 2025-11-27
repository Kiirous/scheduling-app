import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_chip.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:app_agendamento/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NotificationListItem extends AppStateless {
  const NotificationListItem({super.key, required this.notification});

  final Notification notification;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppCard(
      onPressed: () {
        context.push(notification.page);
        if (!notification.isRead) {
          context.read<NotificationsPageCubit>().markNotificationAsRead(notification);
        }
      },
      shadowOffset: const Offset(6, 6),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: notification.isRead ? theme.lightGray : theme.primary,
            ),
            child: Icon(Icons.notifications_outlined, color: notification.isRead ? theme.black : theme.white),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: theme.body16Bold.copyWith(
                          fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w700,
                        ),
                      ),
                    ),
                    AppChip(
                      text: DateFormat('dd MMM').format(notification.createdAt),
                      minWidth: 60,
                      textStyle: notification.isRead ? theme.label11Bold.copyWith(color: theme.black) : null,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(notification.subtitle, style: theme.body13, maxLines: 4, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
