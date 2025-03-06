import 'package:flutter/material.dart';
import 'package:restaurant_app/services/theme_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemePreferencesService _service;
  bool _isDarkMode = false;

  ThemeProvider(this._service) {
    _isDarkMode = _service.getTheme();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _service.saveTheme(_isDarkMode);
    notifyListeners();
  }
}
