class PageModel {
  int id;
  String title;
  String body;
  String mood;
  String imgRep;
  DateTime creation_date;

  PageModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.mood,
      required this.imgRep,
      required this.creation_date});

// function from items into a map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "mood": mood,
      "imgRep": imgRep,
      "creation_date": creation_date
    });
  }
}
