import 'package:flutter/material.dart';

import 'package:habr_rss/constants/enums/theme.dart' as themes;

class ThemeChangeNotifier extends ChangeNotifier {
  ThemeChangeNotifier({required this.theme});

  themes.Theme theme;

  void setTheme(themes.Theme theme) {
    this.theme = theme;
    notifyListeners();
  }
}
