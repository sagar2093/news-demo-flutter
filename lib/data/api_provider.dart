import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as httpDart;
import 'package:news_flutter/constants.dart';
import 'package:news_flutter/model/ArticleResponse.dart';

final headers = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};

abstract class UrlConstants {
  static const String baseUrl = 'https://newsapi.org';
  static const String topHeadlines =
      "$baseUrl/v2/top-headlines?apiKey=$newsApiKey&country=us";
  static const String topHeadlinesIn =
      "$baseUrl/v2/top-headlines?apiKey=$newsApiKey&country=in";
}

Future<ArticleResponse> fetchTopHeadlines() async {
  final response =
      await httpDart.get(Uri.parse(UrlConstants.topHeadlines), headers: headers);
  if (response.statusCode == 200) {
    return compute(parseArticleResponse, response.body);
  } else {
    throw Exception('Failed to load news!');
  }
}

Future<ArticleResponse> fetchTopHeadlinesIn() async {
  final response =
      await httpDart.get(Uri.parse(UrlConstants.topHeadlinesIn), headers: headers);
  if (response.statusCode == 200) {
    return compute(parseArticleResponse, response.body);
  } else {
    throw Exception('Failed to load news!');
  }
}
