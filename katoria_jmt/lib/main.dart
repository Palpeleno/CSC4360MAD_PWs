// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:katoria_jmt/features/themes/themeProvider.dart';
// ignore: unused_import
import 'package:katoria_jmt/features/user_auth/firebase_auth/fireAuthService.dart';
import 'package:katoria_jmt/view/home/main_tab_view.dart';
// ignore: unused_import
import 'package:path/path.dart';
import 'package:provider/provider.dart';
// ignore: unnecessary_import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() async {
// initialize database
  //intialize database for andriod development
  WidgetsFlutterBinding.ensureInitialized();

// Ensure that sqflite_common_ffi is properly initialized
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfiWeb;

  // firebase auth
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
      // TODO change in final sprint
      // change home widget for dev ops testing
      theme: Provider.of<ThemeProvider>(context).themeData,
      // home: WelcomeScreen(),

      // TODO for testing
      home: MainTabView(),

      // //alternative nagivation for pages
      initialRoute: "/",
      routes: {
        // "/": (context) => WelcomeScreen(),
        // "/MainTabView": (context) => MainTabView(),
        // "/LoginPage": (context) => LoginPage(),
        // "/SignUpPage": (context) => SignupPage(),
        // "/HomePage": (context) => HomePage(),

        // for testing
        // "/": (context) => MainTabView(),

        // "/MainTabView": (context) => MainTabView(),
        // "/JounralEntries": (context) => JounralView(),
        // "/Settings": (context) => SettingsView(),

        // "/Profile": (context) => UserProfileView(),
      },
    );
  }
}
