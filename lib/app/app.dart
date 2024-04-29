
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_config.dart';
import '../data/get_it.dart';
import '../data/navigation_service.dart';
import '../model/article.dart';
import '../res/res.dart';
import '../ui/detail/article_detail_screen.dart';
import '../ui/home/dashboard_screen.dart';
import '../ui/home/home_controller.dart';
import '../ui/home/home_tab.dart';
import '../ui/news_category/news_category_controller.dart';
import '../ui/news_category/news_category_tab.dart';
import 'page_not_found.dart';

class NewsDemoApp extends StatelessWidget {
  const NewsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: ThemeData.dark(),
      initialRoute: DashboardScreen.routeName,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (context) {
              switch (routeSettings.name) {
                case DashboardScreen.routeName:
                  return const DashboardScreen();
                case HomeTab.routeName:
                  return ChangeNotifierProvider(
                    create: (_) => HomeController(),
                    child: HomeTab(showAppBar: true,showCategories: true),
                  );
                case NewsCategoryTab.routeName:
                  var arg = ModalRoute.of(context)?.settings.arguments;
                  var category = NewsCategory.values
                      .firstWhereOrNull((e) => e.name == arg.toString());
                  return ChangeNotifierProvider(
                    create: (_) => NewsCategoryController(
                        category ?? NewsCategory.values.first),
                    child: NewsCategoryTab(showAppBar: true),
                  );
                case ArticleDetailScreen.routeName:
                  var arg = ModalRoute.of(context)?.settings.arguments;
                  if (arg is Article) {
                    return ArticleDetailScreen(arg);
                  }
                  return PageNotFound();
                default:
                  return PageNotFound();
              }
            });
      },
    );
  }
}