import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  String? error;
  String? message;
  List<String?>? detail;
  @JsonKey(name: 'non_field_errors')
  List<String?>? nonFieldsError;
  List<String?>? otp;
  List<String?>? password;
  List<String?>? email;
  Map<String, List<String>?>? errors = {};

  ErrorResponse(this.error, this.detail, this.message, this.nonFieldsError,
      this.otp, this.password, this.email, this.errors);

  String getErrorMessage(String defaultError) {
    var msg = error ??
        message ??
        detail?[0] ??
        nonFieldsError?[0] ??
        otp?[0] ??
        password?[0] ??
        email?[0];

    if (errors == null || errors?.isEmpty == true) {
      return msg ?? defaultError;
    } else {
      return errors?.values.first?.first ?? defaultError;
    }

    /*return error ??
        message ??
        detail?[0] ??
        nonFieldsError?[0] ??
        otp?[0] ??
        password?[0] ??
        email?[0] ??
        "Failed to perform action please try again";*/
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
