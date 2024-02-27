import 'package:flutter/material.dart';
import 'package:katoria_jmt/features/user_auth/content/widgets/form_container.dart';
import 'package:katoria_jmt/features/user_auth/content/pages/homePage.dart'; //
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  "Welcome Back",
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
                const FormContainerWidget(
                  hintText: 'Email',
                  isPassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const FormContainerWidget(
                  hintText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 198, 221, 251),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Log in",
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
        ),
      ),
    );
  }
}
