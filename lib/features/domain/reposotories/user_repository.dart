import 'package:dartz/dartz.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/report_user_usecase.dart';
import '../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Stream<Either<Failure, List<UserEntity>>> getAllUsers();
  Stream<Either<Failure, List<UserEntity>>> getBlockedUsers();
  Future<Either<Failure, void>> reportUser(ReportUserParams params);
  Future<Either<Failure, void>> blockUser(String userId);
  Future<Either<Failure, void>> unBlockUser(String blockedUserId);
}