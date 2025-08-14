import 'package:dio/dio.dart';

class ServerException implements Exception {
  DioException? dioErrorObject;
  ServerException({this.dioErrorObject});

  DioException getErrorObject() {
    
    return dioErrorObject!;
  }
}

class CacheException implements Exception {}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message = "Unauthorized"]);

  @override
  String toString() => message;
}
