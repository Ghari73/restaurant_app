import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/settings/theme_provider.dart';
import 'package:restaurant_app/provider/settings/daily_reminder_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final reminderProvider = Provider.of<DailyReminderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),

          ListTile(
            title: const Text("Daily Reminder"),
            subtitle: const Text("Aktifkan pengingat makan siang pukul 11:00 AM"),
            trailing: Switch(
              value: reminderProvider.isReminderOn,
              onChanged: (value) {
                reminderProvider.toggleReminder(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
