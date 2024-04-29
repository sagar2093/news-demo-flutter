import 'package:retrofit/retrofit.dart';

import '../api/base_response.dart';
import '../logger.dart';
import 'error_handler.dart';

Future<BaseResponse<T>> doTryCatch<T>(
    Future<BaseResponse<T>> Function() task) async {
  try {
    return await task();
  } on Exception catch (ex, stacktrace) {
    loggerE("""Exception occurred: 
    $ex 
    stackTrace: 
    $stacktrace""");
    return BaseResponse<T>()..setError(ex.handleError());
  } catch (error) {
    return BaseResponse<T>()..setError(ApiError(error.toString()));
  }
}

extension HandleResponse<T> on HttpResponse<T> {
  BaseResponse<T> handleResponse({Function(T)? onSuccess}) {
    if (data != null) {
      onSuccess?.call(data);
      return BaseResponse<T>()..setData(data);
    } else {
      return BaseResponse<T>()
        ..setError(ApiError(
          "Data not found!",
          code: response.statusCode,
        ));
    }
  }
}
