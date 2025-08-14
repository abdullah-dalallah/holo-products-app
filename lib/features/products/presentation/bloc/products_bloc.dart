import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:holo_products_app/core/usecases/usecase.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  ProductsBloc({required this.getProductsUseCase}) : super(ProductsInitial()) {
    on<GetProducts>(onGetProducts);
  }

  FutureOr<void> onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    emit(LoadingProducts());
    final sendCodeRes = await getProductsUseCase(NoParams());
    emit(await sendCodeRes.fold((failure) {
      return ProductsError(message: failure.getErrorMessage,);
    }, (response) {
        return ProductsLoaded(products: response);
    }));
  }

}
