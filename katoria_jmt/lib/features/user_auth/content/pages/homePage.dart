// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:katoria_jmt/common/color_extension.dart';
// may need to change heading directory from pw1/ -> katoria_jmt/
// if there are future merger conflicts
import 'package:katoria_jmt/features/user_auth/content/pages/loginPage.dart';
import 'package:katoria_jmt/view/main_tab/main_tab_view.dart';

// TODO merge Maintabview here as home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // filler heading
              Text(
                "Home page content in this file c:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    // TODO add color to class

                    color: TColor.primaryAlpha,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                        color: TColor.tertiaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
