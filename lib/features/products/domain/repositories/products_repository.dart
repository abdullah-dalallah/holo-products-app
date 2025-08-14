import 'package:dartz/dartz.dart';
import 'package:holo_products_app/core/error/failures.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}