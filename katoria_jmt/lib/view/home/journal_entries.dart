// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:katoria_jmt/common/color_extension.dart';
import 'package:katoria_jmt/db/page_database.dart';
import 'package:katoria_jmt/view/home/addnewpage_view.dart';
import 'package:katoria_jmt/view/home/item_page.dart';
import 'package:katoria_jmt/view/model/page.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JournalView extends StatefulWidget {
  JournalView({super.key});

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Journal Pages",
          style: TextStyle(color: TColor.tertiaryText),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => setState(() {}),
              icon: Icon(Icons.refresh_outlined))
        ],
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      //  ListView(
      //   padding: EdgeInsets.all(15),
      //   children: [
      //     ItemPage(),
      //     ItemPage(),
      // ItemPage(),
      //   ],
      // ),

      //  new body
      body: FutureBuilder(
        future: PageRepository.getPages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text("empty journal"));
            }
            return ListView(
              padding: EdgeInsets.all(15),
              children: [for (var page in snapshot.data!) ItemPage(page: page)],
            );
          }
          return SizedBox();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
        child: Icon(Icons.note_add_outlined),
      ),

      bottomSheet: SizedBox(
        height: 75,
      ),
    );
  }
}
