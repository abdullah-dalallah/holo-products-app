import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holo_products_app/features/local_cart/domain/entity/cart_item_entity.dart';
import 'package:holo_products_app/features/local_cart/domain/usecases/add_item_cart.dart';
import 'package:holo_products_app/features/local_cart/domain/usecases/get_cart_use_case.dart';
import 'package:holo_products_app/features/local_cart/domain/usecases/remove_item_from_cart.dart';
import 'package:holo_products_app/features/local_cart/domain/usecases/update_item_quantity.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddItemToCartUseCase addItemUseCase;
  final RemoveItemFromCartUseCase removeItemUseCase;
  final UpdateItemQuantityUseCase updateQuantityUseCase;
  CartBloc({
    required this.getCartUseCase,
    required this.addItemUseCase,
    required this.removeItemUseCase,
    required this.updateQuantityUseCase,
  }) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemToCart>(_onAddItem);
    on<RemoveItemFromCart>(_onRemoveItem);
    on<UpdateCartItemQuantity>(_onUpdateQuantity);
  }
  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await getCartUseCase();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddItem(AddItemToCart event, Emitter<CartState> emit) async {

    if (state is CartLoaded) {
      emit(CartLoading());
      try {
        print("adding to cart");
        await addItemUseCase(event.item);
        final updatedItems = await getCartUseCase();
        emit(CartLoaded(updatedItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> _onRemoveItem(RemoveItemFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        await removeItemUseCase(event.id);
        final updatedItems = await getCartUseCase();
        emit(CartLoaded(updatedItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateQuantity(UpdateCartItemQuantity event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        await updateQuantityUseCase(event.id, event.quantity);
        final updatedItems = await getCartUseCase();
        emit(CartLoaded(updatedItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    }
  }

  /// Helper method to calculate total price
  double getTotalPrice() {
    if (state is CartLoaded) {
      final items = (state as CartLoaded).items;
      return items.fold(
          0, (total, item) => total + item.price * item.quantity);
    }
    return 0;
  }
}
