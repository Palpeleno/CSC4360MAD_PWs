// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import '../../common/color_extension.dart';
import 'package:katoria_jmt/db/page_database.dart';
import 'package:katoria_jmt/view/home/main_tab_view.dart';
import 'package:katoria_jmt/view/model/page.dart';
// import '../../common/color_extension.dart';
import '../../db/page_database.dart';

class AddPage extends StatefulWidget {
  final MyPage? page;

  // ignore: use_super_parameters
  AddPage({Key? key, this.page}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // defualt mood
  int selectedMood = 5;

// input controller
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new page"),
        actions: [
//save button
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: FloatingActionButton.extended(
              onPressed: () async {
                setState(() {
                  // insert(page);
                });

                await Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainTabView()));
              },
              label: Text("Save Page"),
              icon: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
// title
            TextField(
              controller: _title,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Give me a title"),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
// mood selection
            //consdier changing to Expanded widget< Container
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        // adjust index to match the mood range
                        selectedMood = index + 1;
                      });
                    },
                    icon: Icon(
                      Icons.mood,
                      size: 16.0,
                      color: selectedMood >= index + 1
                          ? Colors.green
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
//Body text editor
            Expanded(
              child: TextField(
                controller: _description,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "How are you ...",
                ),
                maxLength: 1000,
              ),
            )
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 75,
      ),
    );
  }

  // _insertPage() async {
  //   final page = Page(
  //       title: _title.text,
  //       body: _description.text,
  //       mood: _mood.text,
  //       createdAt: DateTime.now());
  //   await PageRepository.insert(page: page);
  // }
}
