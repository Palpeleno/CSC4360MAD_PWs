import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationScreen extends StatelessWidget {
  final FirebaseAuth _authenticate = FirebaseAuth.instance;

  AuthenticationScreen({Key? key}) : super(key: key);

  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredentials = await _authenticate.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInUser(String email, String password) async {
    try {
      UserCredential userCredentials = await _authenticate.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await _authenticate.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => registerUser('user1@gmail.com', 'password000'),
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () => signInUser('user1@gmail.com', 'password000'),
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
