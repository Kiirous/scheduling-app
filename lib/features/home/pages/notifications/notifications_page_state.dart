part of 'notifications_page_cubit.dart';

class NotificationsPageState extends Equatable {
  const NotificationsPageState({
    this.isLoading = false,
    this.notifications,
    this.page = 0,
    this.finishedLoading = false,
  });

  final bool isLoading;
  final List<Notification>? notifications;
  final int page;
  final bool finishedLoading;

  @override
  List<Object?> get props => [isLoading, notifications, page, finishedLoading];

  NotificationsPageState copyWith({
    bool? isLoading,
    List<Notification>? notifications,
    int? page,
    bool? finishedLoading,
  }) {
    return NotificationsPageState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      finishedLoading: finishedLoading ?? this.finishedLoading,
    );
  }
}
