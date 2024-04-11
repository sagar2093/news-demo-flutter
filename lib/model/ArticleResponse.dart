import 'dart:convert';

import 'package:news_flutter/model/Article.dart';

class ArticleResponse {
  List<Article>? articles;
  String? status;
  String? message;
  int? totalResults;

  ArticleResponse({this.articles, this.status, this.message,this.totalResults});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      articles: json['articles'] != null
          ? (json['articles'] as List).map((i) => Article.fromJson(i)).toList()
          : null,
      status: json['status'],
      message: json['message'],
      totalResults: json['totalResults'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

ArticleResponse parseArticleResponse(String responseBody) {
  return ArticleResponse.fromJson(jsonDecode(responseBody));
}
