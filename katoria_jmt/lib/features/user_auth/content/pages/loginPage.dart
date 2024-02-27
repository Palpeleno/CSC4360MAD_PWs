import 'package:flutter/material.dart';
import 'package:katoria_jmt/features/user_auth/content/widgets/form_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height:30,
            ),
            FormContainerWidget(
              hintText: 'Email',
              isPassword: false,
            ),
            SizedBox(
              height: 10,
            ),
            FormContainerWidget(
              hintText: 'Password',
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
