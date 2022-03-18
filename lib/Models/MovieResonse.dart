import 'package:movies/Models/Movie.dart';

class MovieResponse{
  List<Movie> movies;
  String error;
  MovieResponse(this.movies, this.error);
  MovieResponse.fromJson(Map<String,dynamic> json)
  {
  movies=  json['results'] != null && (json['results'] as List).length > 0
      ? List.from(json['results']).map((element) => Movie.fromJson(element))
      .toSet().toList()
      : [];
     error=json["error"]!=null?json["error"]:"";
  }

}