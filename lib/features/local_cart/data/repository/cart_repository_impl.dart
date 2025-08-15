import 'package:holo_products_app/features/local_cart/data/data_sources/cart_local_data_source.dart';
import 'package:holo_products_app/features/local_cart/data/models/cart_item_model.dart';
import 'package:holo_products_app/features/local_cart/domain/entity/cart_item_entity.dart';
import 'package:holo_products_app/features/local_cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final items = await localDataSource.getCartItems();
    return items.map((e) => CartItemEntity(
      id: e.id,
      title: e.title,
      price: e.price,
      image: e.image,
      quantity: e.quantity,
    )).toList();
  }

  @override
  Future<void> addItem(CartItemEntity item) async {
    final items = await localDataSource.getCartItems();
    final index = items.indexWhere((e) => e.id == item.id);

    if (index == -1) {
      items.add(CartItemModel(
        id: item.id,
        title: item.title,
        price: item.price,
        image: item.image,
        quantity: item.quantity,
      ));
    } else {
      final existing = items[index];
      items[index] = existing.copyWith(quantity: existing.quantity + item.quantity);
    }

    await localDataSource.saveCartItems(items);
  }

  @override
  Future<void> removeItem(int id) async {
    final items = await localDataSource.getCartItems();
    items.removeWhere((e) => e.id == id);
    await localDataSource.saveCartItems(items);
  }

  @override
  Future<void> updateQuantity(int id, int quantity) async {
    final items = await localDataSource.getCartItems();
    final index = items.indexWhere((e) => e.id == id);
    if (index != -1) {
      final existing = items[index];
      items[index] = existing.copyWith(quantity: quantity);
      await localDataSource.saveCartItems(items);
    }
  }
}
