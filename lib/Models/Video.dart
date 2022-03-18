
class Video
{
String id;
String name;
String type;
String key;
String site;
Video(this.id, this.name, this.type, this.key, this.site);
Video.fromJson(Map<String,dynamic>json)
{
  id=json["id"];
  name=json["name"];
  type=json["type"];
  key=json["key"];
  site=json["site"];
}
}