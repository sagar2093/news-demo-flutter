import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:news_flutter/data/api/dev_inspector_widget.dart';
import 'package:news_flutter/ui/home/home_controller.dart';
import 'package:news_flutter/ui/home/home_tab.dart';
import 'package:provider/provider.dart';

import '../../data/api/api_config.dart';
import '../news_category/news_category_controller.dart';
import '../news_category/news_category_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = "DashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showTab = true;

  List<Tab> get tabHeaders => [
        "Home",
        ...NewsCategory.values.map((e) => e.name),
      ]
          .map((e) => Tab(
                text: toBeginningOfSentenceCase(e),
              ))
          .toList();

  List<Widget> get tabChildren => [
        ChangeNotifierProvider(
          create: (_) => HomeController(),
          child: HomeTab(showCategories: !_showTab),
        ),
        ...NewsCategory.values.map((e) => ChangeNotifierProvider(
              create: (_) => NewsCategoryController(e),
              child: NewsCategoryTab(),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: NewsCategory.values.length + 1,
      child: Scaffold(
        appBar: AppBar(
          title: const DevWidget(child: Text("News App")),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _showTab = !_showTab;
                  });
                },
                icon:  Icon(_showTab ? Icons.tab :Icons.tab_unselected))
          ],
          bottom: _showTab
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: TabBar(
                    isScrollable: true,
                    tabs: tabHeaders,
                  ))
              : null,
        ),
        body: _showTab ? TabBarView(children: tabChildren) : tabChildren.first,
      ),
    );
  }
}
