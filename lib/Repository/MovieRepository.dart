import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/CastResonse.dart';
import 'package:movies/Models/GenreResonse.dart';
import 'package:movies/Models/MovieDetails.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Models/PersonResonse.dart';
import 'package:movies/Models/VideoResonse.dart';

class MovieRepository {
  final String apiKey = "c79884c3bed8479539f6c9fcfad8b2e9";
  static String baseUrl = "https://api.themoviedb.org/3";
  final String getPopularMoviesUrl = '$baseUrl/movie/top_rated';
  final String getMoviesUrl = '$baseUrl/discover/movie';
  final String getPlayingUrl = '$baseUrl/movie/now_playing';
  final String getGenreUrl = '$baseUrl/genre/movie/list';
  final String getPersonsUrl = '$baseUrl/trending/person/week';
  final String movieDetails='$baseUrl/movie';
  final String castsUrl='$baseUrl/movie';
  Future<MovieResponse> getMovies({@required int page}) async {
    String url = "$getMoviesUrl?api_key=$apiKey&language=ar&page=$page";
    MovieResponse movieResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("MoviesResponse${response.body}");
      movieResponse = MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieResponse;
  }
  Future<MovieResponse> getPlayingMovies({@required int page}) async {
    String url = "$getPlayingUrl?api_key=$apiKey&language=ar&page=$page";
    MovieResponse movieResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("URLPlaying${response.body}");
      movieResponse = MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieResponse;
  }
  Future<GenreResonse> getGenres({@required int page}) async {
    String url = "$getGenreUrl?api_key=$apiKey&language=ar&page=$page";
    GenreResonse genreResonse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("GenreResponse${response.body}");
      genreResonse = GenreResonse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return genreResonse;
  }

  Future<PersonResonse> getPersons() async {
    String url = "$getPersonsUrl?api_key=$apiKey";
    PersonResonse personResonse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("personResponse${response.body}");
      personResonse = PersonResonse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return personResonse;
  }

  Future<MovieResponse> getMoviesByGenre(
      {@required int genreId, @required page}) async {
    String url =
        "$getMoviesUrl?api_key=$apiKey&language=ar&page=$page&with_genres=$genreId";
    print("movieByGenreURL${url}");
    MovieResponse movieResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("MovieByGenreResponse${response.body}");
      movieResponse = MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieResponse;
  }

  Future<MovieResponse> getPopularMovies({@required page}) async {
    String url = "$getPopularMoviesUrl?api_key=$apiKey&language=ar&page=$page";
    MovieResponse movieResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("popularMoviesResponse${response.body}");
      movieResponse = MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieResponse;
  }
  Future<MovieDetails> getMovieDetails({@required int id}) async {
    String url = "$movieDetails/$id?api_key=$apiKey&language=ar";
    print("movieDetailsUrl$url");
    MovieDetails movieDetail;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("DetailsMovieResponse${response.body}");
      movieDetail = MovieDetails.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieDetail;
  }
  Future<CastResponse> getCasts({@required int id}) async {
    String url = "$castsUrl/$id/credits?api_key=$apiKey&language=ar";
    CastResponse casts;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("castsResponse${response.body}");
      casts = CastResponse.fromJson(json.decode(response.body));
    } else
      {
      throw new Exception(response.body);
      }
    return casts;
  }

  Future<MovieResponse> getSimilarMovie(
      {@required int movieId, @required int page}) async {
    String url = "$movieDetails/$movieId/similar?api_key=$apiKey&language=ar&page=$page";
    print("SimilarMovieUrl$url");
    MovieResponse movieResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("SimilarMovieUrl${response.body}");
      movieResponse = MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieResponse;
  }
  Future<VideoResponse> getMovieVideos(
      {@required int movieId, @required int page}) async {
    String url = "$movieDetails/$movieId/videos?api_key=$apiKey&page=$page";
    print("videosMovieUrl$url");
    VideoResponse videosResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("videosresponse${response.body}");
      videosResponse = VideoResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return videosResponse;
  }
}
