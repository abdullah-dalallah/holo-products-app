import 'package:holo_products_app/features/products/domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity{
  const RatingModel({required super.rate, required super.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}