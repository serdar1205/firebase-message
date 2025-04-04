import 'package:dartz/dartz.dart';
import 'package:firebase_message/core/error/failure.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/entities/message_entity.dart';
import 'package:firebase_message/features/domain/reposotories/message_repository.dart';

class GetMessageUseCase implements StreamUseCase<List<MessageEntity>, MessageParams> {
  final MessageRepository _repository;

  GetMessageUseCase(this._repository);

  @override
  Stream<Either<Failure, List<MessageEntity>>> call(MessageParams params) {
    return _repository.getMessage(params);
  }
}

class MessageParams {
  final String userId;
  final String otherUserId;

  MessageParams({required this.userId, required this.otherUserId});

  Map<String, dynamic> toQueryParams() => {
        'userId': userId,
        'otherUserId': otherUserId,
      };
}
