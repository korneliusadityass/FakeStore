import 'package:json_annotation/json_annotation.dart';

part 'list_products_model.g.dart';

@JsonSerializable()
class GetDataContent {
  GetDataContent({
    required this.id,
    this.title = '',
    this.price = 0,
    this.description = '',
    this.category = '',
    this.image = '',
    required this.rating,
  });
  factory GetDataContent.fromJson(Map<String, dynamic> json) =>
      _$GetDataContentFromJson(json);
  Map<String, dynamic> toJson() => _$GetDataContentToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'category', includeIfNull: false)
  final String? category;
  @JsonKey(name: 'image', includeIfNull: false)
  final String? image;
  final GetRating rating;
}

@JsonSerializable()
class GetRating {
  GetRating({
    this.rate = 0,
    this.count = 0,
  });

  factory GetRating.fromJson(Map<String, dynamic> json) =>
      _$GetRatingFromJson(json);
  Map<String, dynamic> toJson() => _$GetRatingToJson(this);

  @JsonKey(name: 'rate', includeIfNull: false)
  final double? rate;
  @JsonKey(name: 'count', includeIfNull: false)
  final int? count;
}
