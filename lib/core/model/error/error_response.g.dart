// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Failure _$FailureFromJson(Map<String, dynamic> json) => Failure(
      errorCode: json['errorCode'] as int?,
      message: json['message'] as String,
    );

Map<String, dynamic> _$FailureToJson(Failure instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
