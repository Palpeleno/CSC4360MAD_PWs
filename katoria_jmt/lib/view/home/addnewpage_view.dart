// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import '../../common/color_extension.dart';
import 'package:katoria_jmt/db/database_provider.dart';
import 'package:katoria_jmt/view/home/main_tab_view.dart';
import 'package:katoria_jmt/view/model/page_model.dart';

class AddPage extends StatefulWidget {
  final PageModel? page;

  // ignore: use_super_parameters
  AddPage({Key? key, this.page}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // defualt mood
  int selectedMood = 5;

  // late int pageID;
  late String title;
  late String body;
  late int mood;
  late DateTime date;

// input controller
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addPage(PageModel page) {
    DatabaseProvider.db.addNewPage(page);
    // ignore: avoid_print
    print("page added succesfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Page Title"),
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
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "your page",
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            mood = selectedMood;
            date = DateTime.now();

            PageModel page = PageModel(
              // pageID: pageID,
              title: title,
              body: body,
              mood: mood.toString(),
              creation_date: date,
            );
            addPage(page);
          });
          // TODO debug this Navigator of page creation argument

          // main push argument of new page
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainTabView()));
        },
        label: Text("Save Page"),
        icon: Icon(Icons.save),
      ),
      // wrapping for bottom of page, space for bottom navigation bar
      bottomSheet: SizedBox(
        height: 75,
      ),
    );
  }
}
