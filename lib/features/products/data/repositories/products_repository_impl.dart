import 'package:dartz/dartz.dart';
import 'package:holo_products_app/core/error/error_strings/failures.dart';
import 'package:holo_products_app/core/error/exceptions.dart';
import 'package:holo_products_app/core/error/failures.dart';
import 'package:holo_products_app/core/network/network_info.dart';
import 'package:holo_products_app/features/products/data/data_sources/products_local_data_source.dart';
import 'package:holo_products_app/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository{
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({required this.remoteDataSource, required this.networkInfo,required this.localDataSource });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException catch (serverex) {
        return Left(ServerFailure(errorObject: serverex.getErrorObject()));
      }
    } else {
      print("Not connected");
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure(message: FailureMessages.CACHE_FAILURE_MESSAGE));
      }
    }
  }

}