import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MyPage {
  //nullable id
  int? id;
  String title, description, mood, image;
  DateTime createdAt;

  MyPage(
      {this.id,
      // attributes must be passed to MyPage object
      required this.title,
      required this.description,
      required this.mood,
      required this.image,
      required this.createdAt});

// function to create MyPage items into a map
  Map<String, dynamic> toMap() {
    return ({
      "title": title,
      "description": description,
      "mood": mood,
      "imgRep": image,
      "createdAt": createdAt.toString(),
    });
  }
}
