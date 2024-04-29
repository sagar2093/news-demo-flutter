import 'package:flutter/material.dart';

import 'logger.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName) {
    try {
      loggerE('navigateTo: $routeName');
      return navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(routeName, (route) => false);
      //return navigatorKey.currentState?.pushNamed(routeName);
    } catch (e) {
      loggerE(e);
      // return navigatorKey.currentState?.pushNamed(routeName, (route) => false);
    }
    return null;
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
