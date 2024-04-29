import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'data/get_it.dart';
import 'data/prefs.dart';

/// dart run build_runner build --delete-conflicting-outputs
/// flutter run -t lib/main.dart
void main() => mainCommon();

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sharedPrefs.setBool(Prefs.keyLoggerEnabled, !kReleaseMode);
  setupGetIt(sharedPrefs);

  runApp(const NewsDemoApp());
}
