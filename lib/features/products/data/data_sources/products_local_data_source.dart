import 'dart:convert';
import 'package:holo_products_app/core/error/exceptions.dart';
import 'package:holo_products_app/features/products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductsLocalDataSource {
  /// Gets the cached list of products from local storage.
  /// Throws a [CacheException] if no data is found.
  Future<List<ProductModel>> getLastProducts();

  /// Caches the products data locally.
  Future<void> cacheProducts(List<ProductModel> products);
}

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLastProducts() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCTS);
    if (jsonString != null) {
      return Future.value(productsEntityFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) {
    final jsonString = jsonEncode(products.map((p) => p.toJson()).toList());
    return sharedPreferences.setString(CACHED_PRODUCTS, jsonString);
  }
}
