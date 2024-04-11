// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDataContent _$GetDataContentFromJson(Map<String, dynamic> json) =>
    GetDataContent(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: GetRating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDataContentToJson(GetDataContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating,
    };

GetRating _$GetRatingFromJson(Map<String, dynamic> json) => GetRating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$GetRatingToJson(GetRating instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rate', instance.rate);
  writeNotNull('count', instance.count);
  return val;
}
