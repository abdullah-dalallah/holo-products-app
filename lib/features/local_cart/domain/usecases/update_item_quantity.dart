import 'package:holo_products_app/features/local_cart/domain/repository/cart_repository.dart';

class UpdateItemQuantityUseCase {
  final CartRepository repository;
  UpdateItemQuantityUseCase(this.repository);

  Future<void> call(int id, int quantity) async {
    return repository.updateQuantity(id,quantity);
  }
}