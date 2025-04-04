import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/reposotories/user_repository.dart';

class BlockUserUseCase implements UseCase<void, String> {
  final UserRepository _repository;

  BlockUserUseCase(this._repository);


  @override
  Future<Either<Failure, void>> call(String params)async {
    return await _repository.blockUser(params);
  }
}