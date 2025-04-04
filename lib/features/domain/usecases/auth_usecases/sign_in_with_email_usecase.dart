import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/features/domain/reposotories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase/usecase.dart';

class SignInWithEmailUseCase implements UseCase<UserCredential, AuthParams> {
  final AuthRepository repository;

  SignInWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(AuthParams params) async {
    return await repository.signInWithEmailPassword(params);
  }
}

class AuthParams {
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});
}
