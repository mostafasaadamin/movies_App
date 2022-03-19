class MovieDetails
{
  int id;
  bool isAdult;
  int budget;
  String releaseDate;
  int runtime;

 MovieDetails(this.id, this.isAdult, this.budget, this.releaseDate,
      this.runtime);
 MovieDetails.fromJson(Map<String, dynamic>json)
 {
  id = json["id"];
  isAdult = json["adult"];
  budget = json["budget"];
  releaseDate = json["release_date"];
  runtime = json["runtime"];
 }
}