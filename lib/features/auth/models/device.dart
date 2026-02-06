class Device {
  Device({
    required this.id,
    this.fcmToken,
    required this.platform,
    required this.buildNumber,
    required this.locale,
  });

  final String id;
  final String? fcmToken;
  final String platform;
  final int buildNumber;
  final String locale;

  Map<String, dynamic> toJson() {
    return {
      'deviceId': id,
      'fcmToken': fcmToken,
      'platform': platform,
      'buildNumber': buildNumber,
      'locale': locale,
    };
  }
}
