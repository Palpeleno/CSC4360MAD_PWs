// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:katoria_jmt/db/page_database.dart';
import 'package:katoria_jmt/view/home/main_tab_view.dart';
import 'package:katoria_jmt/view/model/page.dart';

// ignore: unused_import
import 'package:katoria_jmt/common/color_extension.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  final MyPage? page;

  const AddPage({Key? key, this.page}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // defualt mood
  int selectedMood = 5;

  // late int pageID;
  // old code for passing attributes of object class MyPage
  late String title;
  late String body;
  late int mood;
  late DateTime date;

// input controller
  final _title = TextEditingController();
  final _description = TextEditingController();
  // initialize variable
  late String _imageString = "";

  @override
  // calls when opening the added page to jounral view screen
  void initState() {
    if (widget.page != null) {
      _title.text = widget.page!.title;
      _description.text = widget.page!.description;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new page"),
        actions: [
//save buttton
          // TODO fox navigation
          // old implementation
          // floatingActionButton (
          //   onPressed: () async {
          //     setState(() {
          //       title = _title.text;
          //       body = _description.text;
          //       mood = selectedMood;
          //       _imageString = _imageString;
          //       date = DateTime.now();

          //       // MyPage page = MyPage(
          //       //   // pageID: pageID,
          //       //   title: title,
          //       //   description: body,
          //       //   mood: mood.toString(),
          //       //   image: _imageString,
          //       //   createdAt: date,
          //       // );
          //     });
          //     _insertPage();
          //     // TODO debug this Navigator of page creation argument
          //     _updatePage();
          //     // main push argument of new page
          //     await Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const MainTabView()));
          //   },
          //   tooltip: 'Save Page',
          //   icon: Icon(Icons.save),
          // ),
// new icon button, does not redirect
          IconButton(
            onPressed: widget.page == null
                ? _insertPage
                : () {
                    _updatePage();
                    Navigator.pop(context);
                  },
            tooltip: "save page",
            icon: Icon(Icons.save),
          ),
          SizedBox(width: 20),
// delete button
          // error when saving might be causing null
          widget.page != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content:
                            Text('Are you sure you want to delte this page'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deltePage();
                            },
                            child: Text('Yes'),
                          )
                        ],
                      ),
                    );
                  },
                  tooltip: "Delete Page",
                  icon: Icon(Icons.delete),
                )
              : const SizedBox()
        ], // action
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// title / description fields
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
// image selection
            ElevatedButton(
              onPressed: _getImage,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: 16, horizontal: 32), // Adjust padding for size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Adjust border radius for shape
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Align children horizontally
                children: [
                  Icon(Icons.image), // Add icon
                  SizedBox(width: 8), // Add space between icon and text
                  Text(
                    "Select an Image",
                    style: TextStyle(color: Colors.green), // Adjust text color
                  ), // Add text
                ],
              ),
            ),
            SizedBox(height: 20),
// Display image
            if (_imageString.isNotEmpty)
              Expanded(
                child: Image.memory(
                  Uint8List.fromList(base64Decode(_imageString)),
                  fit: BoxFit.contain, // Adjust fit as needed
                ),
              ),
          ],
        ),
      ),
      // wrapping for bottom of page, space for bottom navigation bar
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

  // function to select image from gallery
  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageString = base64Encode(Uint8List.fromList(bytes));
      });
    }
  }

// TODO update insert and update methods to include the new image add file
  _insertPage() async {
    final page = MyPage(
      title: _title.text,
      description: _description.text,
      mood: selectedMood.toString(),
      image: _imageString,
      createdAt: DateTime.now(),
    );

    await PageRepository.insert(page: page);
  }

// TODO update method
  _updatePage() async {
    final page = MyPage(
      id: widget.page!.id!,
      title: _title.text,
      description: _description.text,
      mood: selectedMood.toString(),
      image: _imageString,
      createdAt: widget.page!.createdAt,
    );

    await PageRepository.update(page: page);
  }

  //delte function
  _deltePage() async {
    PageRepository.delete(page: widget.page!).then((e) {
      Navigator.pop(context);
    });
  }
}
