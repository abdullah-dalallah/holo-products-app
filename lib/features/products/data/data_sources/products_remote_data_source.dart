import 'package:dio/dio.dart';
import 'package:holo_products_app/constants/endpoint_provider.dart';
import 'package:holo_products_app/constants/url_provider.dart';
import 'package:holo_products_app/core/error/exceptions.dart';
import 'package:holo_products_app/core/utils/server_response.dart';
import 'package:holo_products_app/features/products/data/models/product_model.dart';
import 'package:holo_products_app/injection_container.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>>getProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource{
  final Dio dio;
  ProductsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(UrlProvider.baseUrl + EndPointProvider.products,options: Options(responseType: ResponseType.plain),);

      if (sl<ServerResponse>().getSuccessOrFailed(response.statusCode!)) {
        return productsEntityFromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException(dioErrorObject: e);
    }
  }

}