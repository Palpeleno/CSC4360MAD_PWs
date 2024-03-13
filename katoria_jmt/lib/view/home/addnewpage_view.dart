import 'package:flutter/material.dart';
import 'package:katoria_jmt/db/database_provider.dart';
import 'package:katoria_jmt/view/home/main_tab_view.dart';
import 'package:katoria_jmt/view/model/page_model.dart';
import '../../db/database_provider.dart';


class AddPage extends StatefulWidget {
  final PageModel? page;

  AddPage({Key? key, this.page}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late String title;
  late String body;
  late int selectedMood = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addPage(PageModel page) {
    DatabaseProvider.db.addNewPage(page);
    print("Page added successfully");
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
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your page",
                ),
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

            // Ensure a mood is selected before saving
            if (selectedMood != null) {
              PageModel page = PageModel(
                title: title,
                body: body,
                mood: selectedMood.toString(),
                creation_date: DateTime.now(),
              );
              addPage(page);
            } else {
              // Show an error message or handle the case where no mood is selected
            }
          });

         await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainTabView()),
          ); 

          //Navigator.pop(context);
        },
        label: Text("Save Page"),
        icon: Icon(Icons.save),
      ),
      bottomSheet: SizedBox(
        height: 75,
      ),
    );
  }

  IconData getMoodIcon(int index) {
    switch (index) {
      case 1:
        return Icons.sentiment_very_dissatisfied;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 4:
        return Icons.sentiment_satisfied;
      case 5:
        return Icons.sentiment_very_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}
