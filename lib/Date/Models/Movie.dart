import 'package:hive/hive.dart';
part 'Movie.g.dart';
@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  int id;
  @HiveField(1)
  double popularity;
  @HiveField(2)
  String title;
  @HiveField(3)
  String poster;
  @HiveField(4)
  String backPoster;
  @HiveField(5)
  String overview;
  @HiveField(6)
  double rating;
  @HiveField(7)
  String releaseDate;
  Movie(this.id, this.popularity, this.title, this.poster, this.backPoster,
      this.overview, this.rating);
  Movie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    popularity = json["popularity"];
    title = json["title"];
    poster = json["poster_path"];
    backPoster = json["backdrop_path"];
    overview = json["overview"];
    releaseDate = json["release_date"];
    rating = json["vote_average"].toDouble();
  }
}
