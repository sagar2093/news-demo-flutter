import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/ui/layouts/generic_news_card_large.dart';

import '../../data/logger.dart';
import '../../model/article.dart';
import '../detail/article_detail_screen.dart';
import 'generic_news_card.dart';

class NewsListView extends StatelessWidget {
  const NewsListView(this.items, {super.key});

  final List<Article> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.mapIndexed((index, item) {
        if (index == 0) {
          return GenericNewsCardLarge(
            item,
            onTap: () {
              loggerE(item.toJson().toString());
              Navigator.pushNamed(context, ArticleDetailScreen.routeName,
                  arguments: item);
            },
          );
        }
        return GenericNewsCard(
          item,
          onTap: () {
            loggerE(item.toJson().toString());
            Navigator.pushNamed(context, ArticleDetailScreen.routeName,
                arguments: item);
          },
        );
      }).toList(),
    );
  }
}
