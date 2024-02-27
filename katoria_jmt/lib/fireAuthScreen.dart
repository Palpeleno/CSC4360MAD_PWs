import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationScreen extends StatefulWidget {

  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}


class _AuthenticationScreenState extends State<AuthenticationScreen>{
  final FirebaseAuth _authenticate = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  void _showErrorSnackBar(String eMessage){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(eMessage), duration: Duration(seconds: 3),),
    );
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });

      try {
        await _authenticate.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passController.text.trim());
      } 
      catch (e) {
        _showErrorSnackBar(e.toString());
      }
      finally{
        setState(() {
          _isLoading = false;
        });
      }
    }

    
  }

  Future<void> signInUser() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      try {
        await _authenticate.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passController.text.trim());
      }
      catch (e) {
        _showErrorSnackBar(e.toString());
      }
      finally{
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> signOut() async {
    await _authenticate.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : registerUser,
                  child: Text('Register'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : signInUser,
                  child: Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
