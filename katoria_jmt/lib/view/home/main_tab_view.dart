// main tab view, for navigation through app by logged in users,

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:katoria_jmt/features/user_auth/content/pages/loginPage.dart';
import 'package:katoria_jmt/view/home/journal_entries.dart';
//import 'package:katoria_jmt/view/home/profile_view.dart';
import 'package:katoria_jmt/view/home/settings_view.dart';
import 'package:katoria_jmt/common/color_extension.dart';

// ignore: unused_import
import 'package:sqflite/sqflite.dart';

// ignore: unused_import, depend_on_referenced_packages
import 'package:sqflite_common/sqlite_api.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  // TODO refractor to navigation route
  int selectTab = 0;
  // TODO perhaps have a landing page aka welcome screen for user that
  //shows calender of mood tracker
  Widget currentTabView = JournalView();
  bool isNavigationBarVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTabView,
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isNavigationBarVisible ? kBottomNavigationBarHeight : 0,
        child: Container(
          color: TColor.base,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTabIconButton(
                Icons.settings,
                SettingsView(),
                1,
                "settings",
              ),
              buildTabIconButton(
                Icons.book_outlined,
                JournalView(),
                3,
                "Journal",
              ),
              buildTabIconButton(
                Icons.logout_rounded,
                Container(),
                4,
                "Logout",
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton buildTabIconButton(
      IconData icon, Widget tabView, int tabIndex, String tabName) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 40),
      onPressed: () {
        // if (tabIndex == 1) {
        //   // Navigate to SettingsView using a Navigator
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => SettingsView()),
        //   );
        // }
        if (tabIndex == 4) {
          // TODO correct function for logoutconfirmation
          showLogoutConfirmationDialog(context);
        }
        if (tabIndex == 3) {
          // TODO omit animations to journal tab
          setState(() {
            selectTab = 3;
            currentTabView = JournalView();
          });
        } else {
          // Handle tab changes with animations
          setState(() {
            selectTab = tabIndex;
            currentTabView = tabView;
          });
        }
      },
      tooltip: 'Tab $tabName',
      icon: Icon(
        icon,
        size: 40.0,
        color: TColor.primaryText,
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Logout Confirmation',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              )),
          content: Text('Are you sure you want to log out?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(dialogContext).popUntil((route) => route.isFirst);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Logout',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
            ),
          ],
        );
      },
    );
  }
}
