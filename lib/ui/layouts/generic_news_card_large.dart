import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/res/res.dart';

import '../../model/article.dart';

class GenericNewsCardLarge extends StatelessWidget {
  const GenericNewsCardLarge(this.item, {this.onTap, super.key});

  final Article item;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Dimens.dp8x2),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.dp10x1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.urlToImage != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: item.urlToImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                vs8x2,
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.description != null) ...[
                    vs4x1,
                    Text(
                      item.description?.trim() ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
