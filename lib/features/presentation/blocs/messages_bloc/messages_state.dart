part of 'messages_bloc.dart';

sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

final class MessagesLoading extends MessagesState {}

final class MessagesLoaded extends MessagesState {
  final List<MessageEntity> messages;

  MessagesLoaded({required this.messages});
}

final class MessagesError extends MessagesState {}
