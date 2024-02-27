import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:katoria_jmt/features/app/welcome_screen/welcomeScreen.dart';
import 'package:katoria_jmt/features/user_auth/content/pages/loginPage.dart';

import 'fireAuthScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
  await Firebase.initializeApp();
  }
  catch (e){
    print('Error initizialing Firebase: $e');
  }
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katoria Journal Mood Tracker',
      home: WelcomeScreen(
        child: LoginPage(),
      ),
    );
  }
}