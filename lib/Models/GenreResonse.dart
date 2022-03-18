
import 'package:movies/Models/Genre.dart';

class GenreResonse{
  List<Genre> Genres;
  String error;
  GenreResonse(this.Genres, this.error);
  GenreResonse.fromJson(Map<String,dynamic> json)
  {
    Genres=  json['genres'] != null && (json['genres'] as List).length > 0
      ? List.from(json['genres']).map((element) => Genre.fromJson(element))
      .toSet().toList()
      : [];
 error=json["error"]!=null?json["error"]:"";
  }
}