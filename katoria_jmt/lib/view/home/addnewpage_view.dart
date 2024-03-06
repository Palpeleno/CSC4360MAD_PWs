// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import '../../common/color_extension.dart';

class AddPage extends StatefulWidget {
  AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // defualt mood
  int selectedMood = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12 / .0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Note Title"),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            // mood selection
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(10, (index) {
                  Text("test area for mood");
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
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: TextField(
                // keyboardType: TextInputType.multiline,
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
        onPressed: () {},
        label: Text("Save Page"),
        icon: Icon(Icons.save),
      ),
      bottomSheet: SizedBox(
        height: 75,
      ),
    );
  }
}
