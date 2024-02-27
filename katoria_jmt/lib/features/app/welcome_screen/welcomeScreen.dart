import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  final Widget? child;
  const WelcomeScreen({super.key, this.child});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late String _displayText;
  late int _index;

  @override
  void initState() {
    _displayText = "";
    _index = 0;

    String _fullText = "Welcome to: \n Katoria \n Journal and Mood Tracker  ";

    Timer.periodic(Duration(milliseconds: 75), (Timer timer) {
      if (_index < _fullText.length) {
        setState(() {
          _displayText = _fullText.substring(0, _index + 1);
          _index++;
        });
      } else {
        timer.cancel();
        _nextScreen();
      }
    });
    super.initState();
  }

  void _nextScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget.child!),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.podkovaTextTheme(),
        ),
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 246, 251, 245),
          body: Center(
            child: Text(
              _displayText,
              textAlign: TextAlign.center,
              style: GoogleFonts.podkova(
                  textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
