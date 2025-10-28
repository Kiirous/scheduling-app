import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/home/data/notifications_repository.dart';
import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_page_state.dart';

enum NotificationsStatus { read, notRead }

class NotificationsPageCubit extends Cubit<NotificationsPageState> {
  NotificationsPageCubit({NotificationsRepository? repository, required this.status})
    : _repository = repository ?? getIt(),
      super(const NotificationsPageState(isLoading: false));

  final NotificationsStatus status;
  final NotificationsRepository _repository;

  Future<void> loadNotifications() async {
    if (state.isLoading) return;

    final result = await _repository.getNotifications(state.page);
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
}
