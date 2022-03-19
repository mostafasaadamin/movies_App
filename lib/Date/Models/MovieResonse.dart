
import 'package:movies/Date/Models/Movie.dart';

class MovieResponse{
  List<Movie> movies;
  int totalPages;
  String error;
  MovieResponse(this.movies, this.error);
  MovieResponse.fromJson(Map<String,dynamic> json)
  {
  movies=  json['results'] != null && (json['results'] as List).length > 0
      ? List.from(json['results']).map((element) => Movie.fromJson(element))
      .toSet().toList()
      : [];
     error=json["error"]!=null?json["error"]:"";
    totalPages=json["total_pages"];

  }

}