import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';


class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;


  Future<User?> registerUser(String email, String password) async {
  
      try {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return credential.user;
      } 
      catch (e) {
        print("Error in user registration process");
      }
      return null;
  }

  Future<User?> signInUser(String email, String password) async {
      try {
        UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        return credential.user;
      } 
      catch (e) {
        print("Error in user sign in process");
      }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
