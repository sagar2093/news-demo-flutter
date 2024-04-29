import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:news_flutter/data/api/api_config.dart';
import 'package:news_flutter/data/api/news_api_client.dart';
import 'package:news_flutter/data/api/prod_config.dart';
import 'package:news_flutter/data/news_repository.dart';
import 'package:news_flutter/data/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt(SharedPreferences sharedPreferences) async {
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<Prefs>(Prefs());
  getIt.registerSingleton<Alice>(_getAlice());

  getIt.registerFactory<Dio>(() => _getDio());

  // api clients, alpha sorted
  getIt.registerFactory<NewsApiClient>(() => NewsApiClient(getIt<Dio>()));

  // repositories, alpha sorted
  getIt.registerFactory<NewsRepository>(() => NewsRepositoryImpl());
}

Alice _getAlice() => Alice(
      showNotification: !kReleaseMode,
      showInspectorOnShake: false,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      //maxCallsCount: 1000,
    );

Dio _getDio() {
  final Dio dio = Dio(
    BaseOptions(
        baseUrl: ProdConfig.baseUrl,
        receiveTimeout: const Duration(seconds: 15), // 15 seconds
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15)),
  );

  dio.options.headers.addAll(ApiConfig.headers);
  dio.interceptors.addAll({getIt<Alice>().getDioInterceptor()});
  return dio;
}
