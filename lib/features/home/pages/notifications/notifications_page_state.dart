part of 'notifications_page_cubit.dart';

class NotificationsPageState extends Equatable {
  const NotificationsPageState({
    required this.isLoading,
    this.pendingNotifications,
    this.readNotifications,
    this.pendingCount,
  });

  final bool isLoading;
  final List<Notification>? pendingNotifications;
  final List<Notification>? readNotifications;
  final int? pendingCount;

  @override
  List<Object?> get props => [isLoading, pendingNotifications, readNotifications, pendingCount];

  NotificationsPageState copyWith({
    bool? isLoading,
    List<Notification>? pendingNotifications,
    List<Notification>? readNotifications,
    int? pendingCount,
  }) {
    return NotificationsPageState(
      isLoading: isLoading ?? this.isLoading,
      pendingNotifications: pendingNotifications ?? this.pendingNotifications,
      readNotifications: readNotifications ?? this.readNotifications,
      pendingCount: pendingCount ?? this.pendingCount,
    );
  }
}
