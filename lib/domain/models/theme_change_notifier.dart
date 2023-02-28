import 'package:flutter/material.dart';
import 'package:habr_rss/constants/enums/theme.dart' as theme_enum;

class ThemeChangeNotifier extends ChangeNotifier {
  ThemeChangeNotifier({required this.theme});

  theme_enum.Theme theme;

  void setTheme(theme_enum.Theme theme) {
    this.theme = theme;
    notifyListeners();
  }
}
