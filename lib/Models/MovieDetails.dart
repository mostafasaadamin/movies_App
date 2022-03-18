import 'package:movies/GenresBloc/genres_bloc.dart';
import 'package:movies/Models/Genre.dart';

class MovieDetails
{
  int id;
  bool isAdult;
  int budget;
  List<Genre> genres;
  String releaseDate;
  int runtime;

 MovieDetails(this.id, this.isAdult, this.budget, this.genres, this.releaseDate,
      this.runtime);
 MovieDetails.fromJson(Map<String, dynamic>json)
 {
  id = json["id"];
  isAdult = json["adult"];
  budget = json["budget"];
  genres =  json['genres'] != null && (json['genres'] as List).length > 0
      ? List.from(json['genres']).map((element) => Genre.fromJson(element))
      .toSet().toList()
      : [];
  releaseDate = json["release_date"];
  runtime = json["runtime"];
 }
}