import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/provider/detail/post_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/provider/settings/daily_reminder_provider.dart';
import 'package:restaurant_app/provider/settings/theme_provider.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/notification_service.dart';
import 'package:restaurant_app/services/theme_preferences_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/styles/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/detail/detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final themeService = ThemePreferencesService(sharedPreferences);

  final notificationService = NotificationService();
  notificationService.initNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => ApiServices()),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) => DailyReminderProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                LocalDatabaseProvider(context.read<LocalDatabaseService>())),
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantListProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) => PostProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantDetailProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) => SearchProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(create: (_) => ThemeProvider(themeService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
