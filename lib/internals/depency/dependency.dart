import 'package:shared_preferences/shared_preferences.dart';

class Dependency {
  Dependency({
    required this.sharedPreferences,
  });

  SharedPreferences sharedPreferences;
}
