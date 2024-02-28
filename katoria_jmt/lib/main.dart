import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:katoria_jmt/features/app/welcome_screen/welcomeScreen.dart';
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
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katoria Journal Mood Tracker',
      home: WelcomeScreen(),
    );
  }
}