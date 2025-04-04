import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_message/firebase_options.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'features/presentation/pages/home_page.dart';
import 'locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initLocator();

  runApp(const AppStart());
}


