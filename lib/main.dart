import 'package:flutter/material.dart';
import 'package:habr_rss/internals/app.dart';
import 'package:habr_rss/internals/depency/dependency.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final dependency = Dependency(sharedPreferences: sharedPreferences);

  runApp(App(dependency: dependency));
}
