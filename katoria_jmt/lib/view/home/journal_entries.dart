// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import

import 'package:flutter/material.dart';

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
          style: TextStyle(color: Colors.white),
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
      body: FutureBuilder<List<MyPage>>(
        future: PageRepository.getPages(),
        builder: (context, pageData) {
          switch (pageData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                // ignore: unrelated_type_equality_checks
                if (pageData.data == null || pageData.data!.isEmpty) {
                  return Center(
                    child: Text(
                        "You don't have any jounral pages yet, create one."),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: pageData.data!.length,
                      itemBuilder: (context, index) {
                        MyPage page = pageData.data![index];
                        return Card(
                          child: ListTile(
                            title: Text(page.title),
                            subtitle: Text(page.description),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
            default:
              return Center(
                child: Text(
                    "Unexpected connection state: ${pageData.connectionState}"),
              );
          }
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
