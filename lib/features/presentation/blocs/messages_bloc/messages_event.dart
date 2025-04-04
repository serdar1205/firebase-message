part of 'messages_bloc.dart';

sealed class MessagesEvent {}

class GetMessages extends MessagesEvent {
  final MessageParams params;

  GetMessages(this.params);
}

class SendMessage extends MessagesEvent {
  final SendMessageParams params;

  SendMessage(this.params);
}
