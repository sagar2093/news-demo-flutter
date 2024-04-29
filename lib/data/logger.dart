import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'get_it.dart';

Logger get logger => getIt<Logger>();

//bool get loggerEnabled => getIt<Prefs>().loggerEnabled;
bool get loggerEnabled => !kReleaseMode;

void developerLog(String message) =>
    loggerEnabled ? developer.log(message) : null;

void loggerD(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  if (loggerEnabled) logger.d(message, error: error, stackTrace: stackTrace);
}

void loggerE(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  if (loggerEnabled) logger.e(message, error: error, stackTrace: stackTrace);
}

void loggerV(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  if (loggerEnabled) logger.v(message, error: error, stackTrace: stackTrace);
}

void loggerI(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  if (loggerEnabled) logger.i(message, error: error, stackTrace: stackTrace);
}
