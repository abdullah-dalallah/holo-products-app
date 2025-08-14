
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:holo_products_app/core/network/network_info.dart';
import 'package:holo_products_app/core/utils/AEDGenerator.dart';
import 'package:holo_products_app/features/products/data/data_sources/products_local_data_source.dart';
import 'package:holo_products_app/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:holo_products_app/features/products/data/repositories/products_repository_impl.dart';
import 'package:holo_products_app/features/products/domain/repositories/products_repository.dart';
import 'package:holo_products_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:holo_products_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:holo_products_app/features/theme/data/data_source/theme_local_data_source.dart';
import 'package:holo_products_app/features/theme/data/repository/theme_repository_impl.dart';
import 'package:holo_products_app/features/theme/domain/reopistory/theme_repository.dart';
import 'package:holo_products_app/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:holo_products_app/features/theme/domain/usecases/save_theme_use_case.dart';
import 'package:holo_products_app/features/theme/presntation/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/server_response.dart';
final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  //! feature - Get Products
  getProducts();

  //! feature - Settings theme
  themeSettings();

  //! Core
  sl.registerLazySingleton(() => ServerResponse());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => AEDGenerator());

  //!External
  sl.registerLazySingleton(() => Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

}

getProducts(){
  //bloc
  sl.registerFactory(() => ProductsBloc(getProductsUseCase: sl(),));
  //useCase
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  //Datasource
  sl.registerLazySingleton<ProductsRemoteDataSource>(() =>ProductsRemoteDataSourceImpl( dio: sl(), ));
  //repository
  sl.registerLazySingleton<ProductsRepository>(() =>ProductsRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(),localDataSource: sl() ));
  sl.registerLazySingleton<ProductsLocalDataSource>(() => ProductsLocalDataSourceImpl(sharedPreferences: sl()),);

}


themeSettings(){
  //bloc
  sl.registerFactory(() => ThemeBloc(getThemeUseCase: sl(),saveThemeUseCase: sl()));
  //useCase
  sl.registerLazySingleton(() => GetThemeUseCase(themeRepository: sl()));
  sl.registerLazySingleton(() => SaveThemeUseCase(themeRepository: sl()));
  //Datasource
  sl.registerLazySingleton<ThemeLocalDataSource>(() =>ThemeLocalDataSourceImpl( sharedPreferences: sl(), ));
  //repository
  sl.registerLazySingleton<ThemeRepository>(() =>ThemeRepositoryImpl(themeLocalDataSource: sl()));


}