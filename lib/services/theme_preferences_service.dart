import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferencesService {
  static const String _keyTheme = "IS_DARK_MODE";

  final SharedPreferences _preferences;

  ThemePreferencesService(this._preferences);

  Future<void> saveTheme(bool isDarkMode) async {
    try {
      await _preferences.setBool(_keyTheme, isDarkMode);
    } catch (e) {
      throw Exception("Failed to save theme preference.");
    }
  }

  bool getTheme() {
    return _preferences.getBool(_keyTheme) ?? false;
  }
}
