// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:katoria_jmt/features/user_auth/content/pages/loginPage.dart';
import 'package:katoria_jmt/view/home/addnewpage_view.dart';
import 'package:katoria_jmt/view/home/jounral_entries.dart';
import 'package:katoria_jmt/view/home/profile_view.dart';
import 'package:katoria_jmt/view/home/settings_view.dart';
import 'package:katoria_jmt/common/color_extension.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = JounralView();
  bool isNavigationBarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      body: Stack(
        children: [
          // TODO there might be issue with making subsequent pages so come back here for that
          PageStorage(bucket: pageStorageBucket, child: currentTabView),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: 0,
            right: 0,
            bottom: isNavigationBarVisible ? 0 : -kBottomNavigationBarHeight,
            child: Container(
              color: TColor.base,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTabIconButton(Icons.settings, SettingsView(), 1),
                  buildTabIconButton(
                      Icons.person_4_outlined, UserProfileView(), 2),
                  buildTabIconButton(Icons.book_outlined, JounralView(), 3),
                  buildTabIconButton(Icons.add_comment_outlined, AddPage(), 0),
                  buildTabIconButton(Icons.logout_rounded, Container(), 4),
                ],
              ),
            ),
          ),

          // SafeArea(
          //   child: Column(
          //     children: [
          //       const Spacer(),
          //       Padding(
          //         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          //         child: Stack(
          //           alignment: Alignment.center,
          //           children: [
          //             Image.asset("assets/img/backgroundUtilNavigationbar.png"),
          //             SingleChildScrollView(
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                 children: [
          //                   IconButton(
          //                     padding: EdgeInsets.symmetric(horizontal: 40),
          //                     onPressed: () {
          //                       setState(() {
          //                         selectTab = 1;
          //                         currentTabView = SettingsView();
          //                       });
          //                     },
          //                     tooltip: 'settings',
          //                     icon: Icon(
          //                       Icons.settings,
          //                       size: 40.0,
          //                       color: TColor.tertiaryText,
          //                     ),
          //                   ),
          //                   // SizedBox(width: 40.0),
          //                   IconButton(
          //                     padding: EdgeInsets.symmetric(horizontal: 40),
          //                     onPressed: () {
          //                       setState(() {
          //                         selectTab = 2;
          //                         currentTabView = UserProfileView();
          //                       });
          //                     },
          //                     tooltip: 'profile',
          //                     icon: Icon(
          //                       Icons.person_4_outlined,
          //                       size: 40.0,
          //                       color: TColor.white,
          //                     ),
          //                   ),
          //                   // SizedBox(width: 40.0),
          //                   IconButton(
          //                     padding: EdgeInsets.symmetric(horizontal: 40),
          //                     onPressed: () {
          //                       setState(() {
          //                         selectTab = 3;
          //                         currentTabView = JounralView();
          //                       });
          //                     },
          //                     tooltip: 'Journals',
          //                     icon: Icon(
          //                       Icons.book_outlined,
          //                       size: 40.0,
          //                       color: TColor.white,
          //                     ),
          //                   ),
          //                   // TODO fix redirect for jounral page view
          //                   IconButton(
          //                     padding: EdgeInsets.symmetric(horizontal: 40),
          //                     onPressed: () {
          //                       setState(() {
          //                         selectTab = 0;
          //                         var key;
          //                         currentTabView = AddPage(
          //                         );
          //                       });
          //                     },
          //                     tooltip: 'new page',
          //                     icon: Icon(
          //                       Icons.add_comment_outlined,
          //                       size: 40.0,
          //                       color: TColor.white,
          //                     ),
          //                   ),
          //                   // temp button funtion
          //                   // IconButton(
          //                   //   padding: EdgeInsets.symmetric(horizontal: 40),
          //                   //   onPressed: () {
          //                   //     setState(() {
          //                   //       selectTab = 3;
          //                   //       currentTabView = Container();
          //                   //     });
          //                   //   },
          //                   //   tooltip: 'dark mode/light mode',
          //                   //   icon: Icon(
          //                   //     Icons.dark_mode_outlined,
          //                   //     size: 40.0,
          //                   //     color: TColor.white,
          //                   //   ),
          //                   // ),
          //                   // instead of a new page make a banner pop up reguardless,
          //                   // of page to prompt a logout opportunity
          //                   IconButton(
          //                     padding: EdgeInsets.symmetric(horizontal: 40),
          //                     onPressed: () {
          //                       // TODO check logout void functions redirect to login screen functionality
          //                       // showLogoutConfirmationDialog(context);
          //                       FirebaseAuth.instance.signOut();
          //                       Navigator.pushReplacement(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) => LoginPage()),
          //                       );
          //                       setState(() {
          //                         selectTab = 4;
          //                         currentTabView = Container();
          //                       });
          //                     },
          //                     tooltip: 'logout',
          //                     icon: Icon(
          //                       Icons.logout_rounded,
          //                       size: 40.0,
          //                       color: TColor.white,
          //                     ),
          //                   ),
          //                 ], // icon button children
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  IconButton buildTabIconButton(IconData icon, Widget tabView, int tabIndex) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 40),
      onPressed: () {
        if (tabIndex == 4) {
          // TODO correct function for logoutconfirmation
          showLogoutConfirmationDialog(context);
        } else {
          setState(() {
            selectTab = tabIndex;
            currentTabView = tabView;
          });
        }
      },
      tooltip: 'Tab $tabIndex',
      icon: Icon(
        icon,
        size: 40.0,
        color: TColor.primaryText,
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext dialogContext) {
    //       return AlertDialog(
    //         title: Text('Logout Confirmation'),
    //         content: Text('Are you sure you want to log out?'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(dialogContext).pop(); // Close the dialog
    //             },
    //             child: Text('Cancel'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               FirebaseAuth.instance.signOut();
    //               Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => LoginPage()),
    //               );
    //               setState(() {
    //                 selectTab = 4;
    //                 currentTabView = Container();
    //               });
    //               Navigator.of(dialogContext).pop(); // Close the dialog
    //             },
    //             child: Text('Logout'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
  }
}
