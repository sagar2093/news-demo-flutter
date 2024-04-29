import 'package:flutter/material.dart';
import 'package:news_flutter/data/api/dev_inspector_widget.dart';
import 'package:news_flutter/data/logger.dart';
import 'package:news_flutter/res/dimens.dart';
import 'package:news_flutter/ui/detail/article_detail_screen.dart';
import 'package:news_flutter/ui/layouts/home_categories.dart';
import 'package:news_flutter/ui/layouts/news_list_view.dart';
import 'package:provider/provider.dart';

import '../layouts/generic_news_card.dart';
import 'home_controller.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(
      {this.showAppBar = false, this.showCategories = false, super.key});

  static const routeName = "HomeTab";

  final bool showAppBar;
  final bool showCategories;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context);
    return Scaffold(
      appBar: showAppBar
          ? AppBar(title: const DevWidget(child: Text("News App")))
          : null,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 4,
              color: Colors.white,
              child:
                  controller.loading ? const LinearProgressIndicator() : const SizedBox(),
            ),
            if (showCategories) ...[
              const HomeCategories(),
            ],
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.fetchTopHeadlines(),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: showCategories
                          ? edgeInsetsPageHorizontal
                          : edgeInsetsPage,
                      child: Column(
                        children: [
                          if (controller.errorMessage != null)
                            SizedBox(
                                height: 500,
                                width: double.infinity,
                                child: Text(
                                  controller.errorMessage!,
                                  textAlign: TextAlign.center,
                                )),
                          NewsListView(controller.topHeadlines)
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
