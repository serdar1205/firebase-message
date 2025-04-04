import 'package:firebase_message/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_message/locator.dart';
import 'package:flutter/material.dart';

import 'auth_pages/auth_gate.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              locator<AuthBloc>().add(SignOutEvent());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthGate()),
                    (route) => false, // Predicate function
              );
            },
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Logout'),
            ),
            trailing: Icon(Icons.logout),
          ),
          ListTile(
            onTap: (){},
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Blocked users'),
            ),
            trailing: Icon(Icons.person_remove),
          ),
        ],
      ),
    );
  }
}
