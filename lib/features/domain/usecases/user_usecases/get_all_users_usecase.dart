import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/entities/user_entity.dart';
import 'package:firebase_message/features/domain/reposotories/user_repository.dart';

class GetAllUsersUseCase implements StreamUseCase<List<UserEntity>, NoParams> {
  final UserRepository _repository;

  GetAllUsersUseCase(this._repository);


  @override
  Stream<Either<Failure, List<UserEntity>>> call(NoParams params) {
    return  _repository.getAllUsers();
  }
}