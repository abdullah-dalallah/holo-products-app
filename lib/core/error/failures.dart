import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get getErrorMessage;
  int get getStatusCode;

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final DioException? errorObject;
  ServerFailure({this.errorObject});

  @override
  String get getErrorMessage {
    // Check if errorObject and its response are not null
    if (errorObject?.response != null) {
      // Safely handling potential Error
      return 'An unknown server error occurred.';
    }

    // If there's no response, return a generic error message based on the DioException type
    return errorObject?.message ?? 'An unknown error occurred.';
  }

  @override
  int get getStatusCode => errorObject?.response?.statusCode ?? 0;
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message});

  @override
  String get getErrorMessage => message;

  @override
  int get getStatusCode => -1; // custom non-HTTP code
}

class OfflineFailure extends Failure {
  final String message;

  OfflineFailure({required this.message});

  @override
  // TODO: implement getErrorMessage
  String get getErrorMessage => message;

  @override
  // TODO: implement getStatusCode
  int get getStatusCode => 503;
}