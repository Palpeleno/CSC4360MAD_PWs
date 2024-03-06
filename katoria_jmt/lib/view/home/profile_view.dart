// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:katoria_jmt/features/themes/theme.dart';


class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User profile"),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Text(''),
    );
  }
}
