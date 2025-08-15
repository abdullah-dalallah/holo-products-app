part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddItemToCart extends CartEvent {
  final CartItemEntity item;

  const AddItemToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final int id;

  const RemoveItemFromCart(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateCartItemQuantity extends CartEvent {
  final int id;
  final int quantity;

  const UpdateCartItemQuantity(this.id, this.quantity);

  @override
  List<Object?> get props => [id, quantity];
}
