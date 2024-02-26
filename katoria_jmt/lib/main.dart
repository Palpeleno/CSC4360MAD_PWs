import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fireAuthScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katoria Journal Mood Tracker',
      home: AuthenticationScreen(),
    );
  }
}