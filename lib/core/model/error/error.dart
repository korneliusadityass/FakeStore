import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class ErrorResponse {
  ErrorResponse({
    required this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
  final Error error;
}

@JsonSerializable()
class Error {
  Error({
    required this.code,
    required this.message,
    required this.error,
  });

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);

  final int code;
  final String message;
  final String error;
}

@JsonSerializable()
class ErrorType {
  ErrorType({
    required this.field,
    required this.errorType,
  });

  factory ErrorType.fromJson(Map<String, dynamic> json) =>
      _$ErrorTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorTypeToJson(this);

  final String field;

  @JsonKey(name: 'error_type')
  final String errorType;
}
