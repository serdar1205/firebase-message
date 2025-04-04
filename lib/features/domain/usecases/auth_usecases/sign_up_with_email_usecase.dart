import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/features/domain/reposotories/auth_repository.dart';
import 'package:firebase_message/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase/usecase.dart';


class SignUpWithEmailUseCase implements UseCase<UserCredential, SignUpParams> {
  final AuthRepository repository;

  SignUpWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await repository.signUpWithEmailPassword(params);
  }
}


class SignUpParams {
  const SignUpParams({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  final String name;
  final String surname;
  final String email;
  final String password;

  Map<String, dynamic> toMap() => {
    'name': name,
    'surname': surname,
    'email': email,
    'password': password,
  };
}