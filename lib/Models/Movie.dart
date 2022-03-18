class Movie {
  int id;
  double popularity;
  String title;
  String poster;
  String backPoster;
  String overview;
  double rating;

  Movie(this.id, this.popularity, this.title, this.poster, this.backPoster,
      this.overview, this.rating);

  Movie.fromJson(Map<String, dynamic>json)
  {
    id = json["id"];
    popularity = json["popularity"];
    title = json["title"];
    poster = json["poster_path"];
    backPoster = json["backdrop_path"];
    overview = json["overview"];
    rating = json["vote_average"].toDouble();
  }
}