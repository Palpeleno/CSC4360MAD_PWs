import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:katoria_jmt/features/user_auth/content/pages/loginPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home page content in this file c:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
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
                  color: Color.fromARGB(255, 198, 221, 251),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      color: Colors.black,
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
    );
  }
}