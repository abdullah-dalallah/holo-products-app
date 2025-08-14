import 'package:dartz/dartz.dart';
import 'package:holo_products_app/core/error/error_strings/failures.dart';
import 'package:holo_products_app/core/error/exceptions.dart';
import 'package:holo_products_app/core/error/failures.dart';
import 'package:holo_products_app/core/network/network_info.dart';
import 'package:holo_products_app/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository{
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getProducts();
        return Right(response);
      } on ServerException catch (serverex) {
        return Left(ServerFailure(errorObject: serverex.getErrorObject()));
      }
    } else {
      return Left(OfflineFailure(message: FailureMessages.OFFLINE_FAILURE_MESSAGE));
    }
  }

}