// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:katoria_jmt/common/color_extension.dart';

import 'package:katoria_jmt/db/page_database.dart';
import 'package:katoria_jmt/view/home/addnewpage_view.dart';
import 'package:katoria_jmt/view/home/item_page.dart';
import 'package:katoria_jmt/view/model/page.dart';

// db
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stream/rspc.dart';

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
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
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

// new future builder
      body: FutureBuilder(
          future: PageRepository.getPages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                // check no data or is empty
                return Center(
                  child: Text("no pages: empty"),
                );
              }
              return ListView(
                padding: EdgeInsets.all(15),
                children: [
                  for (var page in snapshot.data!) ItemPage(page: page)
                ],
              );
            } // if the connection state is false
            return SizedBox();
          }),
// new future builder
      // ,sizedBox(),
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
