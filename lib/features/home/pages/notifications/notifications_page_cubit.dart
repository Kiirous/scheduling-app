import 'dart:collection';

import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/home/data/notifications_repository.dart';
import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_page_state.dart';

enum NotificationStatus { read, notRead }

class NotificationsPageCubit extends Cubit<NotificationsPageState> {
  NotificationsPageCubit({NotificationsRepository? repository, required this.status})
    : _repository = repository ?? getIt(),
      super(const NotificationsPageState(isLoading: true));

  final NotificationStatus status;
  final NotificationsRepository _repository;

  Future<void> loadNotifications() async {
    if (state.isLoading && state.notifications != null) return;

    emit(state.copyWith(isLoading: true));
    final result = await _repository.getNotifications(state.page, status == NotificationStatus.read);
    emit(switch (result) {
      Success(:final object) => state.copyWith(
        notifications: state.page == 0 ? object : [...state.notifications!, ...object],
        isLoading: false,
        page: state.page + 1,
        finishedLoading: object.length < 20,
      ),
      Failure() => state.copyWith(isLoading: false),
    });
  }

  void markNotificationAsRead(Notification notification) {
    _repository.markNotificationAsRead(notification.id);
    final readNotification = notification.copyWith(isRead: true);
    emit(
      state.copyWith(
        notifications: state.notifications!.map((e) => e.id == notification.id ? readNotification : e).toList(),
      ),
    );
  }
}
