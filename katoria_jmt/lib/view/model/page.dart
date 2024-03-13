class MyPage {
  //nullable id
  int? id;
  String title, description;
  String mood;
  // String imgRep;
  DateTime createdAt;

  MyPage(
      {this.id,
      // attributes must be passed to MyPage object
      required this.title,
      required this.description,
      required this.mood,
      // required this.imgRep,
      required this.createdAt});

// function to create MyPage items into a map
  Map<String, dynamic> toMap() {
    return ({
      "title": title,
      "description": description,
      "mood": mood,
      // "imgRep": imgRep,
      "creation_date": createdAt.toString(),
    });
  }

// Convert Map to MyPage
  factory MyPage.fromMap(Map<String, dynamic> map) {
    return MyPage(
      // pageID: map['pageID'],
      title: map['title'],
      description: map['description'],
      mood: map['mood'],
      // imgRep: map['imgRep'],
      createdAt: DateTime.parse(map['creation_date']),
    );
  }
}
