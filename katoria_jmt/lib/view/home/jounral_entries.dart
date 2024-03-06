// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:katoria_jmt/common/color_extension.dart';
import 'package:katoria_jmt/db/database_provider.dart';
import 'package:katoria_jmt/view/model/page_model.dart';
// import 'package:katoria_jmt/db/database_provider.dart';
// import 'package:sqflite/sqflite.dart';

// import './newpage_view.dart';

class JounralView extends StatefulWidget {
  JounralView({Key? key});

  @override
  _JounralViewState createState() => _JounralViewState();
}

class _JounralViewState extends State<JounralView> {
  Future<List<PageModel>> getPages() async {
    final pages = await DatabaseProvider.db.getPages();
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal Pages"),
        // backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      // backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<List<PageModel>>(
          future: getPages(),
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
                          PageModel page = pageData.data![index];
                          return Card(
                            child: ListTile(
                              title: Text(page.title),
                              subtitle: Text(page.body),
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
          }),
    );
  }
}
