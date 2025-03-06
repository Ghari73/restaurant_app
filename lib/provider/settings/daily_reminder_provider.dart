import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/services/notification_service.dart';

class DailyReminderProvider extends ChangeNotifier {
  bool _isReminderOn = false;
  final NotificationService _notificationService = NotificationService();

  bool get isReminderOn => _isReminderOn;

  DailyReminderProvider() {
    _loadFromPrefs();
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderOn = prefs.getBool('daily_reminder') ?? false;
    notifyListeners();
  }

  void toggleReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderOn = value;
    prefs.setBool('daily_reminder', _isReminderOn);

    if (_isReminderOn) {
      await _notificationService.scheduleDailyReminder();
    } else {
      await _notificationService.cancelNotification();
    }

    notifyListeners();
  }
}
