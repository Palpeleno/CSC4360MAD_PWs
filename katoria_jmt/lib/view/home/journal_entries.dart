// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:katoria_jmt/common/color_extension.dart';
import 'package:katoria_jmt/db/database_provider.dart';
import 'package:katoria_jmt/view/home/addnewpage_view.dart';
import 'package:katoria_jmt/view/model/page_model.dart';
// import 'package:sqflite/sqflite.dart';

class JounralView extends StatelessWidget {
  JounralView({Key? key});

  Future<List<PageModel>> getPages() async {
    final page = await DatabaseProvider.db.getPages();
    return page;
  }

  @override
  Widget build(BuildContext context) {
    final ModalRoute<Object?> page =
        ModalRoute.of(context) as ModalRoute<Object?>;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Journal Pages",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
      ),
      bottomSheet: SizedBox(
        height: 75,
      ),
    );
  }
}


// class JounralView extends StatelessWidget {
//   Future<List<PageModel>> getPages() async {
//     final page = await DatabaseProvider.db.getPages();
//     return page;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Journal Pages",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.onBackground,
//       ),
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: FutureBuilder<List<PageModel>>(
//         future: getPages(),
//         builder: (context, pageData) {
//           switch (pageData.connectionState) {
//             case ConnectionState.waiting:
//               {
//                 return Center(child: CircularProgressIndicator());
//               }
//             case ConnectionState.done:
//               {
//                 if (pageData.data == null || pageData.data!.isEmpty) {
//                   return Center(
//                     child: Text(
//                         "You don't have any jounral pages yet, create one."),
//                   );
//                 } else {
//                   return Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: ListView.builder(
//                       itemCount: pageData.data!.length,
//                       itemBuilder: (context, index) {
//                         PageModel page = pageData.data![index];
//                         return Card(
//                           child: ListTile(
//                             title: Text(page.title),
//                             subtitle: Text(page.body),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               }

//             default:
//               return Center(
//                 child: Text(
//                     "Unexpected connection state: ${pageData.connectionState}"),
//               );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.note_add_outlined),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddPage()),
//           );
//         },
//       ),
//       bottomSheet: SizedBox(
//         height: 75,
//       ),
//     );
//   }
// }
