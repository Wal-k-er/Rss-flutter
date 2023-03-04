import 'package:flutter/material.dart';
import 'package:habr_rss/domain/models/theme_change_notifier.dart';
import 'package:habr_rss/constants/enums/theme.dart' as themes;
import 'package:habr_rss/screens/home_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeChangeNotifier>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getThemeData(themeNotifier),
      home: const HomeRssPage(),
    );
  }

  ThemeData getThemeData(ThemeChangeNotifier themeNotifier) {
    final ThemeData theme;

    switch (themeNotifier.theme) {
      case themes.Theme.dark:
        theme = ThemeData.dark();
        break;
      case themes.Theme.light:
        theme = ThemeData.light();
        break;
    }
    return theme;
  }
}
