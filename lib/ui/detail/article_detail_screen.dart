import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/data/api/dev_inspector_widget.dart';
import 'package:news_flutter/res/dimens.dart';
import 'package:news_flutter/ui/layouts/in_app_web_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen(this.item, {super.key});

  static const routeName = "ArticleDetailPage";

  final Article item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DevWidget(child: Text("News Detail")),
      ),
      body: Column(
        children: [
          if (item.urlToImage != null)
            CachedNetworkImage(
              imageUrl: item.urlToImage!,
              maxHeightDiskCache: 400,
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: edgeInsetsPage,
                child: Column(
                  children: [
                    Text(
                      item.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    vs10x1,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.author ?? item.source?.name ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          item.formattedPublishedAt ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    vs10x1,
                    Text(
                      item.description ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FilledButton(
              onPressed: () async{
                //context.openInAppWebUrl(item.url ?? '');
                if(await canLaunchUrlString(item.url??'')){
                  launchUrlString(item.url??'');
                }
              },
              child: const Text("Read More")),
          vs10x2,
        ],
      ),
    );
  }
}
