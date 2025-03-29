

import 'package:firebase_message/core/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'features/presentation/pages/home_page.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chatting',
        theme: AppTheme.lightTheme(),
        home: HomePage()
    );
  }
}