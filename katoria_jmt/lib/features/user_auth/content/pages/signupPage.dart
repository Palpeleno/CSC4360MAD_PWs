import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
// may need to change heading directory from pw1/ -> katoria_jmt/
// if there are future merger conflicts
import 'package:pw1/features/user_auth/content/pages/homePage.dart';
import 'package:pw1/features/user_auth/content/pages/loginPage.dart';
import 'package:pw1/features/user_auth/content/widgets/form_container.dart';
import 'package:pw1/features/user_auth/firebase_auth/fireAuthService.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});
// TODO update proper created statefile for signup merge confict with back end homepage
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>  {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthenticationService _auth = AuthenticationService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
        backgroundColor: const Color.fromARGB(255, 246, 251, 245),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User?\nCreate an account!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.podkova(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: 'Username',
                  isPassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                FormContainerWidget(
                  controller: _emailController,
                  hintText: 'Email',
                  isPassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                FormContainerWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 25,
                ),

                GestureDetector(
                  onTap:_signUp,
                  child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 198, 221, 251),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
                SizedBox(height:22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?\t"),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text("Log in", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.registerUser(email, password);
    if(user !=  null){
      print("Account created succesfully!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    else{
      print("Error. Cannot register user.");
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content :Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
