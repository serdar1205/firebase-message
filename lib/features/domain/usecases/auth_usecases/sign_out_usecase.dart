import 'package:dartz/dartz.dart';
import 'package:firebase_message/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase/usecase.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}

