import 'package:json_annotation/json_annotation.dart';

part 'detail_product_model.g.dart';

@JsonSerializable()
class GetDataProductContent {
  GetDataProductContent({
    required this.id,
    required this.title,
    required this.price,
    // required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
  factory GetDataProductContent.fromJson(Map<String, dynamic> json) =>
      _$GetDataProductContentFromJson(json);
  Map<String, dynamic> toJson() => _$GetDataProductContentToJson(this);

  final int id;
  final String title;
  final double price;
  // final String description;
  final String category;
  final String image;
  final GetRating rating;
}

@JsonSerializable()
class GetRating {
  GetRating({
    required this.rate,
    required this.count,
  });

  factory GetRating.fromJson(Map<String, dynamic> json) =>
      _$GetRatingFromJson(json);
  Map<String, dynamic> toJson() => _$GetRatingToJson(this);

  @JsonKey(name: 'rate', includeIfNull: false)
  final double rate;
  @JsonKey(name: 'count', includeIfNull: false)
  final int count;
}
