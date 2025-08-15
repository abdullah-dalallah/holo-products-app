import 'package:holo_products_app/features/local_cart/domain/entity/cart_item_entity.dart';
import 'package:holo_products_app/features/local_cart/domain/repository/cart_repository.dart';

class AddItemToCartUseCase {
  final CartRepository repository;
  AddItemToCartUseCase(this.repository);

  Future<void> call(CartItemEntity item) async {
    return repository.addItem(item);
  }
}