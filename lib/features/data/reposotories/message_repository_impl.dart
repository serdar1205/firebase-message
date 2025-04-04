import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/network/network.dart';
import 'package:firebase_message/features/domain/entities/message_entity.dart';
import 'package:firebase_message/features/domain/reposotories/message_repository.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/get_message_usecase.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/send_message_usecase.dart';
import '../../../core/constants/strings/app_strings.dart';
import '../datasources/remote/message_remote_datasource.dart';

class MessageRepositoryImpl implements MessageRepository {
  final NetworkInfo networkInfo;
  final MessageRemoteDatasource remoteDataSource;

  MessageRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessage(
      MessageParams params) async* {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      yield const Left(ConnectionFailure(AppStrings.noInternet));
      return;
    }

    yield* remoteDataSource.getMessage(params).map((messages) {
      try {
        final messageEntities =
            messages.map((message) => message.toEntity()).toList();
        return Right(messageEntities);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> sendMessage(SendMessageParams params)async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.sendMessage(params);
        return Right(response);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return const Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}
