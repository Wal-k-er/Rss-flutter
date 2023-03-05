import 'package:flutter/material.dart';
import 'package:habr_rss/domain/notifiers/theme_change_notifier.dart';
import 'package:habr_rss/internals/depency/dependency.dart';
import 'package:habr_rss/presents/screens/home_screen.dart';
import 'package:habr_rss/constants/enums/theme.dart' as themes;
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.dependency,
  }) : super(key: key);

  final Dependency dependency;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeChangeNotifier themeChangeNotifier =
      ThemeChangeNotifier(theme: themes.Theme.light);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.dependency),
        ChangeNotifierProvider.value(value: themeChangeNotifier),
      ],
      child: const HomeScreen(),
    );
  }
}
