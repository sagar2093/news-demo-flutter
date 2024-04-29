
import '../handler/error_handler.dart';
import '../logger.dart';

/// Reference: https://medium.com/globant/easy-way-to-implement-rest-api-calls-in-flutter-9859d1ab5396
class BaseResponse<T> {
  ApiError? _error;

  T? data;

  bool hasError() => _error != null;

  ApiError? get error => _error;
  String? get errorMessage => _error?.message;
  Map<String,List<String>?>? get errors => _error?.errors;

  setError(ApiError? error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  toLoggerE(Map<String,dynamic>? data,{String? info}){
    loggerE("""
    result=${toString()}
    data=$data,
    info=$info,
    error=${error?.toJson()}
    """);
  }
}
