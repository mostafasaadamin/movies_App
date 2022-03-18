import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'movie_genre_event.dart';
part 'movie_genre_state.dart';

class MovieGenreBloc extends Bloc<MovieGenreEvent, MovieGenreState> {
  MovieGenreBloc() : super(MovieGenreInitial());
  MovieRepository repo=MovieRepository();
  List<Movie> movies;
  @override
  Stream<MovieGenreState> mapEventToState(
    MovieGenreEvent event,
  ) async* {
    if(event is FetchGenreMovies)
    {
      yield LoadingState();
      try{
        print("FetchGenreMovies${event.genreId}");
        MovieResponse response =await repo.getMoviesByGenre(genreId: event.genreId,page: 1);
        if(response!=null)
          yield LoadedState(movieList: response.movies);
        else
          yield ErrorState(error: "NO data  Found");
      }on SocketException {
        yield ErrorState(error: 'No Internet',);
      } on HttpException {
        yield ErrorState(error: 'No Service Found',);
      } on FormatException {
        yield ErrorState(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorState(error: 'Unknown Error',);
      }
    }
  }
}
