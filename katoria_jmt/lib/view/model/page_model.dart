class PageModel {
  // int pageID;
  String title;
  String body;
  String mood;
  // String imgRep;
  DateTime creation_date;

  PageModel(
      {
      //required this.pageID,
      required this.title,
      required this.body,
      required this.mood,
      // required this.imgRep,
      required this.creation_date});

// function to create PageModel items into a map
  Map<String, dynamic> toMap() {
    return ({
      // "pageID": pageID,
      "title": title,
      "body": body,
      "mood": mood,
      // "imgRep": imgRep,
      "creation_date": creation_date.toIso8601String(),
    });
  }

// Convert Map to PageModel
  factory PageModel.fromMap(Map<String, dynamic> map) {
    return PageModel(
      // pageID: map['pageID'],
      title: map['title'],
      body: map['body'],
      mood: map['mood'],
      // imgRep: map['imgRep'],
      creation_date: DateTime.parse(map['creation_date']),
    );
  }
}
