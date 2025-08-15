import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holo_products_app/features/local_cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> saveCartItems(List<CartItemModel> items);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cartKey = 'LOCAL_CART';

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final jsonString = sharedPreferences.getString(cartKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => CartItemModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final jsonString = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(cartKey, jsonString);
  }

  @override
  Future<void> clearCart() async {
    await sharedPreferences.remove(cartKey);
  }
}
