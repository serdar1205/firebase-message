import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/core/constants/strings/app_strings.dart';
import 'package:firebase_message/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../widgets/home_widgets/chat_list_item.dart';
import '../widgets/home_widgets/search_widget.dart';
import 'chat_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 164),
          child: AppBar(
              flexibleSpace: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 6),
                    child: Text(AppStrings.messages,style: TextStyle(color: AppColors.black,fontSize: 32,fontWeight: FontWeight.w600),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: SearchWidget(
                      searchCtrl: _searchCtrl,
                      onSearch: () {
                        setState(() {});
                      },
                      onClear: () {
                        setState(() {});
                        _searchCtrl.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },

                    ),
                  ),
                  Divider()
                ],
              ),

          ),
        ),
        body: ListView.separated(
            itemCount: 30,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(
                user: UserModel(
                fullName: "Oliver Clark",
                lastMessageBody: "I'm good too. I just wanted to chat with you.",
                lastSeenDateTime: DateTime.now().toString(),
                userAvatar: ImageAssets.noImage,
              ).toEntity(),)));
            },
            child:   ChatListItem(
              user: UserModel(
                fullName: "Oliver Clark",
                lastMessageBody: "I'm good too. I just wanted to chat with you.",
                lastSeenDateTime: DateTime.now().toString(),
                userAvatar: ImageAssets.noImage,
              ).toEntity(),
              notSeenCount: "1",
              isOnline: true,
            ),
          );
        },
        separatorBuilder: (context, separateIndex){
              return Divider();
        },
        ),
      ),
    );
  }
}

