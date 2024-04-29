
import 'package:shared_preferences/shared_preferences.dart';

import 'get_it.dart';

class Prefs {
  final SharedPreferences _prefs = getIt<SharedPreferences>();

  static const String keyLoggerEnabled = "key_logger_enabled";
}