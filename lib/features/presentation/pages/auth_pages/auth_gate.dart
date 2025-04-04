import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_message/features/presentation/pages/home_page.dart';
import 'package:firebase_message/locator.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
        if(snapshot.hasData){
          locator<AuthBloc>().add(GetCurrentUserEvent());
          return HomePage();
        }else{
          return AuthPage();
        }
      }),
    );
  }
}
