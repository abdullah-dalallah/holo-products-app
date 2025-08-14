
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:holo_products_app/core/network/network_info.dart';
import 'package:holo_products_app/core/utils/AEDGenerator.dart';
import 'package:holo_products_app/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:holo_products_app/features/products/data/repositories/products_repository_impl.dart';
import 'package:holo_products_app/features/products/domain/repositories/products_repository.dart';
import 'package:holo_products_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:holo_products_app/features/products/presentation/bloc/products_bloc.dart';

import 'core/utils/server_response.dart';
final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  //! feature - Get Products
  getProducts();

  //! Core
  sl.registerLazySingleton(() => ServerResponse());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => AEDGenerator());

  //!External
  sl.registerLazySingleton(() => Dio());

}

getProducts(){
  //bloc
  sl.registerFactory(() => ProductsBloc(getProductsUseCase: sl(),));
  //useCase
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  //Datasource
  sl.registerLazySingleton<ProductsRemoteDataSource>(() =>ProductsRemoteDataSourceImpl( dio: sl(), ));
  //repository
  sl.registerLazySingleton<ProductsRepository>(() =>ProductsRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

}
