import 'dart:developer';

import 'package:firebase_message/features/domain/entities/user_entity.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/get_message_usecase.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/send_message_usecase.dart';
import 'package:firebase_message/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_message/features/presentation/blocs/messages_bloc/messages_bloc.dart';
import 'package:firebase_message/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_widgets/action_bar.dart';
import '../widgets/chat_widgets/appbar_title.dart';
import '../widgets/chat_widgets/message_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user, this.isOnline = false});

  final UserEntity user;
  final bool isOnline;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final authBloc = locator<AuthBloc>();
  final messageBloc = locator<MessagesBloc>();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final _messageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    log(authBloc.userId.toString(), name: 'senderId');
    log(widget.user.id.toString(), name: 'userId');

    Future.microtask(() {
      messageBloc.add(GetMessages(MessageParams(
          userId: authBloc.userId!, otherUserId: widget.user.id!)));
    });

    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     Future.delayed(Duration(milliseconds: 500), () => scrollDown());
    //   }
    // });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_messageCtrl.text.isNotEmpty) {
      messageBloc.add(
          SendMessage(SendMessageParams(widget.user.id!, _messageCtrl.text)));
      _messageCtrl.clear();
      //  Future.delayed(Duration(milliseconds: 200), () => scrollDown()); // Wait a bit before scrolling
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 65),
        child: AppBar(
          forceMaterialTransparency: true,
          centerTitle: false,
          leadingWidth: 40,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              size: 28,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: AppBarTitle(
            messageData: widget.user,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: DemoMessageList(
            senderId: authBloc.userId,
            scrollController: _scrollController,
          )),
          ActionBar(
            focusNode: _focusNode,
            onSendClicked: sendMessage,
            onMicrophoneClicked: () {},
            textEditingController: _messageCtrl,
          )
        ],
      ),
    );
  }
}
