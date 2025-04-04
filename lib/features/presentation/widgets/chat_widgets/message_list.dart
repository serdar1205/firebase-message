import 'package:firebase_message/core/utils/date_converter.dart';
import 'package:firebase_message/features/presentation/blocs/messages_bloc/messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_box.dart';

class DemoMessageList extends StatelessWidget {
  const DemoMessageList(
      {super.key, required this.senderId, required this.scrollController});

  final String? senderId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: BlocBuilder<MessagesBloc, MessagesState>(
        builder: (context, state) {
          return switch (state) {
            MessagesInitial() => Center(child: Text('Start messaging!')),
            MessagesLoading() => Center(child: Text('Loading')),
            MessagesLoaded(:final messages) => ListView(
                controller: scrollController,
                children: messages.map((message) {
                  return MessageBox(
                    isMyMessage: senderId == message.senderId,
                    message: message.message,
                    messageDate: formatTimestamp(message.timestamp),
                  );
                }).toList()),
            MessagesError() => Center(child: Text('Error')),
          };
        },
      ),
    );
  }
}
