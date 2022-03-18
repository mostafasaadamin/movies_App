import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/CastResonse.dart';
import 'package:movies/Models/MovieDetails.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Models/VideoResonse.dart';

class MovieRepository {
  final String apiKey = "c79884c3bed8479539f6c9fcfad8b2e9";
  static String baseUrl = "https://api.themoviedb.org/3";
  final String getMoviesUrl = '$baseUrl/discover/movie';
  final String movieDetails='$baseUrl/movie';
  final String castsUrl='$baseUrl/movie';
  final String searchMovieUrl='$baseUrl/search/movie';

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


  Future<MovieResponse> searchForMovies({@required searchedMovie, @required int page}) async {
    String url = "$searchMovieUrl?api_key=$apiKey&language=ar&page=$page&query=$searchedMovie";
    print("SearchedMoviesurl${url}");

    MovieResponse movieResponse;
    final client = new http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print("SearchedMoviesResponse${response.body}");
      movieResponse = MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
    return movieResponse;
  }

}
