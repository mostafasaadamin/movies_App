class Cast{
  int id;
  String charachter;
  String name;
  String image;
  Cast(this.id, this.charachter, this.name, this.image);
  Cast.fromJson(Map<String, dynamic>json)
  {
    id = json["cast_id"];
    name = json["name"];
    image = json["profile_path"];
    charachter = json["character"];
  }
}