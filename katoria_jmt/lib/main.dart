// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// may need to change heading directory from pw1/ -> katoria_jmt/
// if there are future merger conflicts
import 'package:katoria_jmt/features/app/welcome_screen/welcomeScreen.dart';
// ignore: unused_import
import 'package:katoria_jmt/features/themes/theme.dart';
import 'package:katoria_jmt/features/themes/themeProvider.dart';
// ignore: unused_import
import 'package:katoria_jmt/features/user_auth/firebase_auth/fireAuthService.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBfrhUdkHCMnFNtM88B7JPaDNSFlTNEbz8",
      appId: "1:695374748289:android:c1a038c0b095daa589cb80",
      messagingSenderId: "695374748289",
      projectId: "katoriajmt",
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katoria Journal Mood Tracker',
      home: WelcomeScreen(),
    );
  }
}
