import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_flutter/res/dimens.dart';
import 'package:news_flutter/ui/detail/article_detail_screen.dart';
import 'package:news_flutter/ui/news_category/news_category_controller.dart';
import 'package:provider/provider.dart';

import '../../data/api/dev_inspector_widget.dart';
import '../layouts/generic_news_card.dart';
import '../layouts/news_list_view.dart';

class NewsCategoryTab extends StatelessWidget {
  const NewsCategoryTab({this.showAppBar = false, super.key});

  static const routeName = "NewsCategoryTab";

  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<NewsCategoryController>(context);
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: DevWidget(
                child: Text(
                    toBeginningOfSentenceCase(controller.newsCategory.name)),
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 4,
              color: Colors.white,
              child: controller.loading
                  ? const LinearProgressIndicator()
                  : const SizedBox(),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.fetchTopHeadlines(),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: edgeInsetsPage,
                      child: Column(
                        children: [
                          if (controller.errorMessage != null)
                            SizedBox(
                              height: 500,
                              width: double.infinity,
                              child: Text(
                                controller.errorMessage!,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          NewsListView(controller.topHeadlines),
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
