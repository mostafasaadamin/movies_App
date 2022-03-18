class Person {
  int id;
  double popularity;
  String name;
  String profileImage;
  String Know;


  Person(this.id, this.popularity, this.name, this.profileImage, this.Know);

  Person.fromJson(Map<String, dynamic>json)
  {
    id = json["id"];
    popularity = json["popularity"].toDouble();
    name = json["name"];
    profileImage = json["profile_path"];
    Know = json["known_for_department"];
  }
}