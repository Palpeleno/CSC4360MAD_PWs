import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class WelcomeScreen extends StatefulWidget{
  final Widget? child;
  const WelcomeScreen({super.key, this.child});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen>{

  @override
  void initState(){
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> widget.child!), (route) => false);
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome to Katoria Jounal and Mood Tracker App", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}