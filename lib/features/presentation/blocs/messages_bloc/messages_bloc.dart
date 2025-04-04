import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_message/features/domain/entities/message_entity.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/get_message_usecase.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/send_message_usecase.dart';

import '../../../../locator.dart';

part 'messages_event.dart';

part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final GetMessageUseCase _getMessageUseCase = GetMessageUseCase(locator());
  final SendMessageUseCase _sendMessageUseCase = SendMessageUseCase(locator());

  MessagesBloc() : super(MessagesLoading()) {
    on<GetMessages>(_onGetMessages);
    on<SendMessage>(_onSendMessage);
  }

  final List<MessageEntity> _messages = [];


  Future<void> _onGetMessages(
      GetMessages event, Emitter<MessagesState> emit) async {
    emit(MessagesLoading());

    await emit.forEach(
      _getMessageUseCase(event.params),
      onData: (data) => data.fold((failure) => MessagesError(), (messages) {
        if (messages.isNotEmpty) {
          _messages.clear();
          _messages.addAll(messages);
          return MessagesLoaded(messages: List.from(_messages));
        } else {
          return MessagesInitial();
        }
      }),
      onError: (_, __) => MessagesError(),
    );
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<MessagesState> emit) async {
    final result = await _sendMessageUseCase.call(event.params);

    result.fold((failure) {
      log(failure.message, name: 'failure --');
    }, (success) {
      log('-------', name: 'success --');
      MessagesLoaded(messages: _messages);
      //emit(MessagesLoaded(messages: messages))
    });
  }
}
