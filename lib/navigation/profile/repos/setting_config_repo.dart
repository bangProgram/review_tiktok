import 'package:shared_preferences/shared_preferences.dart';

class SettingConfigRepo {
  final SharedPreferences _preferences;

  static const String muted = "muted";
  static const String autoPlay = "autoPlay";

  Future<void> setMuted(bool value) async {
    await _preferences.setBool(muted, value);
  }

  Future<void> setAutoPlay(bool value) async {
    _preferences.setBool(autoPlay, value);
  }

  bool getMuted() {
    return _preferences.getBool(muted) ?? false;
  }

  bool getAutoPlay() {
    return _preferences.getBool(autoPlay) ?? false;
  }

  SettingConfigRepo(this._preferences);
}
