import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum AppPreferenceKeys { onboardingDone, deviceId }

class AppPreferences {
  AppPreferences(this._preferences);

  final SharedPreferences _preferences;

  bool get shouldShowOnboarding => !(_preferences.getBool(AppPreferenceKeys.onboardingDone.name) ?? false);

  void setOnboardingDone() {
    _preferences.setBool(AppPreferenceKeys.onboardingDone.name, true);
  }

  String get deviceId {
    if (_preferences.containsKey(AppPreferenceKeys.deviceId.name)) {
      return _preferences.getString(AppPreferenceKeys.deviceId.name)!;
    } else {
      final uuid = const Uuid().v4();
      _preferences.setString(AppPreferenceKeys.deviceId.name, uuid);
      return uuid;
    }
  }
}
