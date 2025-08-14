import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}


abstract class UseCaseStream<Type, Params> {
  Stream<Type> call(Params params);
}

//if we had a get class and we don't need to pass any params we do like below
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

//and we pass noparams to params part of the implements usecase <send..,noparams>