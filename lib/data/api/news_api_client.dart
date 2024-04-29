import 'package:dio/dio.dart';
import 'package:news_flutter/data/api/prod_config.dart';
import 'package:news_flutter/model/article.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/source.dart';

part 'news_api_client.g.dart';

/// dart run build_runner build --delete-conflicting-outputs
@RestApi(baseUrl: ProdConfig.baseUrl)
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio, {String? baseUrl}) = _NewsApiClient;

  static const _basePath = "/v2";

  static const String sources = "$_basePath/sources";
  static const String topHeadlines = "$_basePath/top-headlines";
  static const String topHeadlinesSources = "$_basePath/top-headlines/sources";
  static const String everything = "$_basePath/everything";

  @GET(sources)
  Future<HttpResponse<SourceResponse>> fetchSources();

  @GET(topHeadlinesSources)
  Future<HttpResponse<SourceResponse>> fetchTopHeadlinesSources();

  @GET(topHeadlines)
  Future<HttpResponse<ArticleResponse>> fetchTopHeadlines({
    @Query("q") String? q,
    @Query("country") String? country,
    @Query("category") String? category,
    @Query("sources") String? sources,
    @Query("language") String? language = "en",
  });

  @GET(everything)
  Future<HttpResponse<SourceResponse>> fetchEverything({
    @Query("q") String? q,
    @Query("sortBy") String? sortBy,
    @Query("sources") String? sources,
    @Query("domains") String? domains,
    @Query("pageSize") int? pageSize,
    @Query("page") int? page,
  });
}
