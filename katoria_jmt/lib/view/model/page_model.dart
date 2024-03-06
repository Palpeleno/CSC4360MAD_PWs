class PageModel {
  // int id;
  String title;
  String body;
  String mood;
  // String imgRep;
  DateTime creation_date;

  PageModel(
      {
      // required this.id,
       required this.title,
      required this.body,
      required this.mood,
      // required this.imgRep,
      required this.creation_date});

// function from PageModel into a map
  Map<String, dynamic> toMap() {
    return ({
      // "id": id,
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
      // id: map['id'],
      title: map['title'],
      body: map['body'],
      mood: map['mood'],
      // imgRep: map['imgRep'],
      creation_date: DateTime.parse(map['creation_date']),
    );
  }
}
