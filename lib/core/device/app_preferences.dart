import 'package:shared_preferences/shared_preferences.dart';

enum AppPreferenceKeys { onboardingDone }

class AppPreferences {
  AppPreferences(this._preferences);

  final SharedPreferences _preferences;

  bool get shouldShowOnboarding =>
     !(_preferences.getBool(AppPreferenceKeys.onboardingDone.name) ?? false);

  void setOnboardingDone() {
    _preferences.setBool(AppPreferenceKeys.onboardingDone.name, true);
  }
}
