import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/home/data/notifications_datasource.dart';
import 'package:app_agendamento/features/home/models/notification.dart';

class NotificationsRepository {
  NotificationsRepository(this._datasource);

  final NotificationsDatasource _datasource;

  Future<Result<void, List<Notification>>> getNotifications(int page, bool read) {
    return _datasource.getNotifications(page, read);
  }
}
