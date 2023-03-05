import 'package:flutter/material.dart';
import 'package:habr_rss/domain/notifiers/theme_change_notifier.dart';
import 'package:habr_rss/constants/enums/theme.dart' as themes;
import 'package:provider/provider.dart';

class ThemeSwitchWidget extends StatefulWidget {
  ThemeSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final themeChangeNotifier = context.read<ThemeChangeNotifier>();

    return Switch(
        value: isActive,
        onChanged: (bool value) {
          setState(() {
            isActive = !isActive;
            switch (themeChangeNotifier.theme) {
              case themes.Theme.dark:
                themeChangeNotifier.setTheme(themes.Theme.light);
                break;
              case themes.Theme.light:
                themeChangeNotifier.setTheme(themes.Theme.dark);
                break;
            }
          });
        });
  }
}
