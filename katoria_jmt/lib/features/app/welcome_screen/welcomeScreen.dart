import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
// may need to change heading directory from pw1/ -> katoria_jmt/
// if there are future merger conflicts
import 'package:pw1/features/user_auth/content/pages/loginPage.dart';
import 'package:pw1/features/user_auth/content/pages/signupPage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late String _displayText;
  late int _index;
  late AnimationController _textAnimationController;
  late AnimationController _loginButtonController;
  late AnimationController _signupButtonController;
  bool _isLoginButtonVisible = false;
  bool _isSignupButtonVisible = false;

  @override
  void initState() {
    _displayText = "";
    _index = 0;
    _textAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 30));
    _loginButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _signupButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    String _fullText = "Katoria\nJournal and Mood Tracker";

    Timer.periodic(Duration(milliseconds: 45), (Timer timer) {
      if (_index < _fullText.length) {
        setState(() {
          _displayText = _fullText.substring(0, _index + 1);
          _index++;
        });
      } else {
        timer.cancel();
        _textAnimationController.forward();
      }
    });

    _textAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            _isLoginButtonVisible = true;
          });
          _loginButtonController.forward();
        });
      }
    });

    _loginButtonController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            _isSignupButtonVisible = true;
          });
          _signupButtonController.forward();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _loginButtonController.dispose();
    _signupButtonController.dispose();
    super.dispose();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _textAnimationController,
                builder: (context, child) {
                  return Text(
                    _displayText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.podkova(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
              if (_isLoginButtonVisible)
                FadeTransition(
                  opacity: _loginButtonController,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                            .animate(_loginButtonController),
                    child: buildAnimatedButton(
                      text: "Log in",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(height: 20),
              if (_isSignupButtonVisible)
                FadeTransition(
                  opacity: _signupButtonController,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                            .animate(_signupButtonController),
                    child: buildAnimatedButton(
                      text: "Sign up",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedButton(
      {required String text, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 207, 225, 251),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
      ),
    );
  }
}
