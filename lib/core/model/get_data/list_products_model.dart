import 'package:json_annotation/json_annotation.dart';

part 'list_products_model.g.dart';

@JsonSerializable()
class GetDataContent {
  GetDataContent({
    required this.id,
    required this.title,
    // required this.price,
    // required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
  factory GetDataContent.fromJson(Map<String, dynamic> json) => _$GetDataContentFromJson(json);
  Map<String, dynamic> toJson() => _$GetDataContentToJson(this);

  final int id;
  final String title;
  // final double price;
  // final String description;
  final String category;
  final String image;
  final GetRating rating;
}

@JsonSerializable()
class GetRating {
  GetRating({
    this.rate = 0,
    this.count = 0,
  });

  factory GetRating.fromJson(Map<String, dynamic> json) => _$GetRatingFromJson(json);
  Map<String, dynamic> toJson() => _$GetRatingToJson(this);

  @JsonKey(name: 'rate', includeIfNull: false)
  final double? rate;
  @JsonKey(name: 'count', includeIfNull: false)
  final int? count;
}
