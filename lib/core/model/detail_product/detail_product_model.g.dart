// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDataProductContent _$GetDataProductContentFromJson(
        Map<String, dynamic> json) =>
    GetDataProductContent(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
      rating: GetRating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDataProductContentToJson(
        GetDataProductContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating,
    };

GetRating _$GetRatingFromJson(Map<String, dynamic> json) => GetRating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$GetRatingToJson(GetRating instance) => <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };
