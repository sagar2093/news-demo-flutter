import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../res/strings.dart';
import '../get_it.dart';
import '../logger.dart';
import '../prefs.dart';
import 'error_response.dart';

part 'error_handler.g.dart';

@JsonSerializable()
class ApiError implements Exception {
  int? code;
  String? message;
  Map<String, List<String>?>? errors;

  ApiError(this.message, {this.code, this.errors});

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

extension LogException on Exception {
  logException(Object? error, StackTrace stackTrace) {
    loggerE("Exception occurred: $error stackTrace: $stackTrace");
  }

  logExceptionStackTrace(stackTrace) {
    loggerE("Exception stackTrace: $stackTrace");
  }
}

extension ErrorHandler on Exception {
  ApiError handleError({String? defaultError}) {
    defaultError ??= AppStrings.defaultError;
    String _errorMessage = 'Unknown error!';
    Map<String, List<String>?>? _errors;
    int? _errorCode;
    if (this is DioException) {
      var error = this as DioException;
      _errorCode = error.response?.statusCode;
      /*var prefs = getIt<Prefs>();
      if (prefs.loggedInAuthToken.isNotEmpty &&
          _errorCode == HttpStatusCodes.unauthorized) {
        prefs.logout();
        getIt<NavigationService>().navigateTo(LoginScreen.routeName);
        return ApiError(AppStrings.unauthorizedUser,
            code: _errorCode, errors: _errors);
      }*/
      //loggerE(error);
      switch (error.type) {
        case DioExceptionType.cancel:
          _errorMessage = "Request was cancelled";
          break;
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          _errorMessage = "Connection timeout!";
          break;
        case DioExceptionType.badResponse:
          developerLog('errorType: type = DioExceptionType.badResponse');
          developerLog('errorType: message = ${error.message}');
          try {
            var errorBody = error.response?.data;
            var errorResponse = ErrorResponse.fromJson(errorBody);
            _errors = errorResponse.errors;
            _errorMessage = errorResponse.getErrorMessage(defaultError);
          } catch (ex) {
            _errorMessage = error.message?.isEmpty==true ? AppStrings.defaultError : error.message ?? 'Unknown error!';
          }
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketConnectionException') ==true ||
              error.message?.contains('SocketException') == true) {
            _errorMessage = AppStrings.failedToConnectServer;
          } else {
            _errorMessage = error.error.toString();
          }
          break;
      }
    } else {
      _errorMessage = toString();
    }
    return ApiError(_errorMessage, code: _errorCode, errors: _errors);
  }
}

/// For more codes: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
class HttpStatusCodes {
  // informational responses
  static const continue_ = 100;

  // successful responses
  static const ok = 200;
  static const created = 201;
  static const accepted = 201;

  // redirection messages
  static const multipleChoice = 300;
  static const movedPermanently = 301;

  //client error codes
  static const badRequest = 400;
  static const unauthorized = 401;
  static const paymentRequired = 402;
  static const forbidden = 403;
  static const notFound = 404;
  static const methodNotAllowed = 405;
  static const proxyAuthenticationRequired = 407;
  static const requestTimeout = 408;
  static const conflict = 409;
  static const unProcessableEntity = 422; // validation error code
  static const tooManyRequests = 429;

  // server error responses
  static const internalServerError = 500;
  static const notImplemented = 501;
}
