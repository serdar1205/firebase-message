import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase/usecase.dart';

class GetCurrentUserUseCase implements UseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
