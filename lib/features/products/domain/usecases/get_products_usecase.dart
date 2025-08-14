import 'package:dartz/dartz.dart';
import 'package:holo_products_app/core/error/failures.dart';
import 'package:holo_products_app/core/usecases/usecase.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/products/domain/repositories/products_repository.dart';

class GetProductsUseCase extends UseCase<List<ProductEntity>,NoParams>{
  final ProductsRepository repository;
  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await repository.getProducts();
  }

}