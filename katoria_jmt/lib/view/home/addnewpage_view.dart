import 'package:flutter/material.dart';
import 'package:katoria_jmt/db/page_database.dart';
import 'package:katoria_jmt/view/home/main_tab_view.dart';
import 'package:katoria_jmt/view/model/page.dart';
import 'package:katoria_jmt/view/model/page_model.dart';
// import '../../common/color_extension.dart';
import '../../db/database_provider.dart';

class AddPage extends StatefulWidget {
  final MyPage? page;

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
        actions: [
//save button
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: FloatingActionButton.extended(
              onPressed: () async {
                _insertPage();
                // setState(() {
                //   // insert(page);
                // });

                // await Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => MainTabView()));
                print("save button succesfully saved the page");
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
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMood = index + 1;
                      });
                    },
                    icon: Icon(
                      getMoodIcon(index + 1),
                      size: 30.0,
                      color: selectedMood == index + 1
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
                  border: InputBorder.none,
                  hintText: "your page",
                ),
                maxLength: 1000,
              ),
            ),
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
