import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../error/failure.dart';

abstract class UseCase<T, P> {
  /// Future<T> call(P param);
  Future<Either<Failure, T>> call(P params);
}
abstract class StreamUseCase<T, P> {
  Stream<Either<Failure, T>> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
