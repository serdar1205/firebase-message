

import 'package:dartz/dartz.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/get_message_usecase.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/send_message_usecase.dart';
import '../../../core/error/failure.dart';
import '../entities/message_entity.dart';

abstract class MessageRepository{
  Stream<Either<Failure, List<MessageEntity>>> getMessage(MessageParams params);
  Future<Either<Failure, void>> sendMessage(SendMessageParams params);


}
