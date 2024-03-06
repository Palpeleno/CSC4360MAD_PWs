// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:katoria_jmt/features/themes/button.dart';
import 'package:katoria_jmt/features/themes/theme.dart';
import 'package:katoria_jmt/features/themes/themeProvider.dart';
import 'package:provider/provider.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground,
            ),
            backgroundColor:
                Theme.of(context).colorScheme.background,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      myButton(
                        color: Theme.of(context).colorScheme.secondary,
                        onTap: () {
                          Provider.of<ThemeProvider>(context,
                                  listen: false)
                              .toggleTheme();
                        },
                      ),
                      const SizedBox(width: 200),
                      Text(
                        "Change Theme",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
