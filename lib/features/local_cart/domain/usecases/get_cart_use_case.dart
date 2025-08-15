import 'package:holo_products_app/features/local_cart/domain/entity/cart_item_entity.dart';
import 'package:holo_products_app/features/local_cart/domain/repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;
  GetCartUseCase(this.repository);

  Future<List<CartItemEntity>> call() async {
    return repository.getCartItems();
  }
}