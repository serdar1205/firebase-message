import 'dart:developer';
import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/core/constants/strings/app_strings.dart';
import 'package:firebase_message/features/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:firebase_message/features/presentation/pages/settings_page.dart';
import 'package:firebase_message/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final userBloc =  locator<UsersBloc>();
  @override
  void initState() {
    super.initState();
   userBloc.add(GetAllUsers());
  }
  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 167),
          child: AppBar(
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.messages, style: TextStyle(
                          color: AppColors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),),
                      IconButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SettingsPage()));
                      }, icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
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
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            log(state.toString());
            return switch(state){
              UsersLoading() => Center(child:  CircularProgressIndicator(),),
              UsersLoaded(:final users) => ListView.separated(
                itemCount: users.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {

                  final user = state.users[index];
                  return
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(
                          user:user)));
                      },
                      child: ChatListItem(
                        user: user,
                        notSeenCount: "1",
                        isOnline: true,
                      ),
                    );
                },
                separatorBuilder: (context, separateIndex) {
                  return Divider();
                },
              ),
              UsersFailure() => Center(child: Text('Error ...'),),
              UsersEmpty() => Center(child: Text('Empty'),),
            };
          }
        ),
      ),
    );
  }
}

