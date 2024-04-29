import 'package:news_flutter/data/handler/response_handler.dart';
import 'package:news_flutter/model/article.dart';
import 'package:news_flutter/model/source.dart';

import 'api/base_response.dart';
import 'api/news_api_client.dart';
import 'get_it.dart';

abstract class NewsRepository {
  Future<BaseResponse<SourceResponse>> fetchSources();

  Future<BaseResponse<SourceResponse>> fetchTopHeadlinesSources();

  Future<BaseResponse<ArticleResponse>> fetchTopHeadlines(
      {String? q, String? country, String? category, String? sources});

  Future<BaseResponse<SourceResponse>> fetchEverything(
      {String? q,
      String? sortBy,
      String? sources,
      String? domains,
      int? pageSize,
      int? page});
}

class NewsRepositoryImpl extends NewsRepository {
  final _apiClient = getIt<NewsApiClient>();

  @override
  Future<BaseResponse<SourceResponse>> fetchSources() {
    return doTryCatch(() async {
      var httpResponse = await _apiClient.fetchSources();
      return httpResponse.handleResponse();
    });
  }

  @override
  Future<BaseResponse<SourceResponse>> fetchTopHeadlinesSources() {
    return doTryCatch(() async {
      var httpResponse = await _apiClient.fetchTopHeadlinesSources();
      return httpResponse.handleResponse();
    });
  }

  @override
  Future<BaseResponse<ArticleResponse>> fetchTopHeadlines(
      {String? q, String? country, String? category, String? sources}) {
    return doTryCatch(() async {
      var httpResponse = await _apiClient.fetchTopHeadlines(
          q: q, country: country, category: category, sources: sources);
      return httpResponse.handleResponse();
    });
  }

  @override
  Future<BaseResponse<SourceResponse>> fetchEverything(
      {String? q,
      String? sortBy,
      String? sources,
      String? domains,
      int? pageSize,
      int? page}) {
    return doTryCatch(() async {
      var httpResponse = await _apiClient.fetchEverything(
          q: q,
          sortBy: sortBy,
          sources: sources,
          domains: domains,
          pageSize: pageSize,
          page: page);
      return httpResponse.handleResponse();
    });
  }
}
