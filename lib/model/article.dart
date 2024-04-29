import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_flutter/data/logger.dart';
import 'package:news_flutter/model/source.dart';
part 'article.g.dart';

@JsonSerializable()
class ArticleResponse {
  String? status;
  int? totalResults;
  List<Article>? articles;
  String? message;

  ArticleResponse({
    this.status,
    this.totalResults,
    this.articles,
    this.message,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}

@JsonSerializable()
class Article {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  Source? source;

  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
  });

  String? get formattedPublishedAt {
    try {
      return DateFormat("yyyy-MM-dd HH:mm")
          .format(DateTime.parse(publishedAt ?? ''));
    } catch (e) {
      loggerE(e);
      return null;
    }
  }

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
