import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/network/network.dart';
import 'package:firebase_message/features/data/datasources/remote/user_remote_datasource.dart';
import 'package:firebase_message/features/domain/entities/user_entity.dart';
import 'package:firebase_message/features/domain/reposotories/user_repository.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/report_user_usecase.dart';
import '../../../core/constants/strings/app_strings.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Stream<Either<Failure, List<UserEntity>>> getAllUsers() async* {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      yield const Left(ConnectionFailure(AppStrings.noInternet));
      return;
    }

    yield* remoteDataSource.getAllUsers().map((usersList) {
      try {
        final userEntities = usersList.map((user) => user.toEntity()).toList();
        return Right(userEntities);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Stream<Either<Failure, List<UserEntity>>> getBlockedUsers() async* {
    final bool isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      yield const Left(ConnectionFailure(AppStrings.noInternet));
      return;
    }

    yield* remoteDataSource.getBlockedUsers().map((usersList) {
      try {
        final userEntities = usersList.map((user) => user.toEntity()).toList();
        return Right(userEntities);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> blockUser(String userId) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.blockUser(userId);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, void>> reportUser(ReportUserParams params) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.reportUser(params);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, void>> unBlockUser(String blockedUserId) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.unBlockUser(blockedUserId);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}
