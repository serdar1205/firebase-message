import 'package:firebase_message/features/domain/entities/user_entity.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        children: [Expanded(child: DemoMessageList()), ActionBar()],
      ),
    );
  }
}
