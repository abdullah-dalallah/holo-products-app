import 'package:holo_products_app/features/local_cart/domain/repository/cart_repository.dart';

class RemoveItemFromCartUseCase {
  final CartRepository repository;
  RemoveItemFromCartUseCase(this.repository);

  Future<void> call(int id) async {
    return repository.removeItem(id);
  }
}