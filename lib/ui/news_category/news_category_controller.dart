import 'package:flutter/foundation.dart';
import 'package:news_flutter/data/get_it.dart';
import 'package:news_flutter/data/news_repository.dart';

import '../../data/api/api_config.dart';
import '../../data/api_state.dart';
import '../../model/article.dart';

class NewsCategoryController with ChangeNotifier {
  NewsCategoryController(NewsCategory category) {
    _category = category;
    fetchTopHeadlines();
  }

  final _repo = getIt<NewsRepository>();

  ApiState _apiState = ApiState.idle;
  late NewsCategory _category;
  List<Article> _topHeadlines = [];
  String? _errorMessage;

  bool get loading => _apiState.isLoading;

  String? get errorMessage => _errorMessage;

  NewsCategory get newsCategory => _category;

  List<Article> get topHeadlines => _topHeadlines.where((element) => element.title!="[Removed]").toList();

  Future<void> fetchTopHeadlines() async {
    _apiState = ApiState.loading;
    notifyListeners();

    var result = await _repo.fetchTopHeadlines(
      category: _category.name,
    );
    if (result.errorMessage == null) {
      if (result.data?.status == "ok") {
        _topHeadlines = result.data?.articles ?? [];
        _errorMessage = null;
        _apiState = ApiState.success;
      } else {
        _apiState = ApiState.error;
        _errorMessage = result.data?.message;
      }
    } else {
      _apiState = ApiState.error;
      _errorMessage = result.errorMessage;
      result.toLoggerE(result.data?.toJson(), info: "fetchTopHeadlines()");
    }
    notifyListeners();
  }
}
