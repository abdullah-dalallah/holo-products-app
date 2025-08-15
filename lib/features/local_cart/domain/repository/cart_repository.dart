import 'package:holo_products_app/features/local_cart/domain/entity/cart_item_entity.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCartItems();
  Future<void> addItem(CartItemEntity item);
  Future<void> removeItem(int id);
  Future<void> updateQuantity(int id, int quantity);
}
