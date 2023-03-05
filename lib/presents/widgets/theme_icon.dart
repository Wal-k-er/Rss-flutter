import 'package:flutter/material.dart';
import 'package:habr_rss/constants/enums/theme.dart' as themes;
import 'package:habr_rss/domain/notifiers/theme_change_notifier.dart';
import 'package:provider/provider.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(_getAppBarIcon(context));
  }

  IconData _getAppBarIcon(BuildContext context) {
    final theme = context.watch<ThemeChangeNotifier>().theme;

    switch (theme) {
      case themes.Theme.dark:
        return Icons.lightbulb_outline;
      case themes.Theme.light:
        return Icons.lightbulb;
    }
  }
}
