import 'dart:convert';

import 'package:holo_products_app/features/products/data/models/rating_model.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';

List<ProductModel> productsEntityFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productsEntityToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel extends ProductEntity{
  const ProductModel({required super.id, required super.title, required super.price, required super.description, required super.category, required super.image, required super.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: RatingModel.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating.toJson(),
  };
}