

import 'package:firebase_message/core/config/theme/app_theme.dart';
import 'package:firebase_message/features/presentation/pages/auth_pages/auth_page.dart';
import 'package:firebase_message/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/presentation/blocs/messages_bloc/messages_bloc.dart';
import 'features/presentation/blocs/users_bloc/users_bloc.dart';
import 'features/presentation/pages/auth_pages/auth_gate.dart';
import 'features/presentation/pages/home_page.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context)=>locator()),
        BlocProvider<UsersBloc>(create: (context)=>locator()),
        BlocProvider<MessagesBloc>(create: (context)=>locator()),
      ],
      child: MaterialApp(
          title: 'Chatting',
          theme: AppTheme.lightTheme(),
          home: AuthGate()
      ),
    );
  }
}

