class Notification {
  const Notification({
    required this.id,
    required this.isRead,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.createdAt,
  });

  final String id;
  final bool isRead;
  final String title;
  final String subtitle;
  final String page;
  final DateTime createdAt;

  factory Notification.fromJson(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] as String,
      isRead: map['isRead'] as bool,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      page: map['page'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
