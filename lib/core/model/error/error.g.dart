// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      error: Error.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      code: json['code'] as int,
      message: json['message'] as String,
      error: json['error'] as String,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'error': instance.error,
    };

ErrorType _$ErrorTypeFromJson(Map<String, dynamic> json) => ErrorType(
      field: json['field'] as String,
      errorType: json['error_type'] as String,
    );

Map<String, dynamic> _$ErrorTypeToJson(ErrorType instance) => <String, dynamic>{
      'field': instance.field,
      'error_type': instance.errorType,
    };
