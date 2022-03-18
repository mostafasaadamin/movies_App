
import 'package:movies/Models/Person.dart';

class PersonResonse{
  List<Person> persons;
  String error;
  PersonResonse(this.persons, this.error);
  PersonResonse.fromJson(Map<String,dynamic> json)
  {
    persons=  json['results'] != null && (json['results'] as List).length > 0
      ? List.from(json['results']).map((element) => Person.fromJson(element))
      .toSet().toList()
      : [];
 error=json["error"]!=null?json["error"]:"";
  }
}