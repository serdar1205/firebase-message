import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/reposotories/message_repository.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final MessageRepository _repository;

  SendMessageUseCase(this._repository);


  @override
  Future<Either<Failure, void>> call(SendMessageParams params)async {
    return await _repository.sendMessage(params);
  }
}

class SendMessageParams{
  final String receiverId;
  final dynamic message;

  SendMessageParams(this.receiverId, this.message);
}