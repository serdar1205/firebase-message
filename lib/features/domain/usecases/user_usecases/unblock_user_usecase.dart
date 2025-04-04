import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/reposotories/user_repository.dart';

class UnblockUserUseCase implements UseCase<void, String> {
  final UserRepository _repository;

  UnblockUserUseCase(this._repository);


  @override
  Future<Either<Failure, void>> call(String params)async {
    return await _repository.unBlockUser(params);
  }
}