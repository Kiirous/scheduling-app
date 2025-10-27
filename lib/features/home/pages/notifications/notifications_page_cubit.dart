import 'package:app_agendamento/features/home/models/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_page_state.dart';

class NotificationsPageCubit extends Cubit<NotificationsPageState> {
  NotificationsPageCubit() : super(const NotificationsPageState(isLoading: false));

  Future<void> loadPendingNotifications() async {

  }

  Future<void> loadReadNotifications() async {

  }
}
