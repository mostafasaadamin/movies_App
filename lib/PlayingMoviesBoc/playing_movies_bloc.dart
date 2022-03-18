import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'playing_movies_event.dart';
part 'playing_movies_state.dart';

class PlayingMoviesBloc extends Bloc<PlayingMoviesEvent, PlayingMoviesState> {
  PlayingMoviesBloc() : super(PlayingMoviesInitial());
  MovieRepository repo=MovieRepository();
  List<Movie> movies;
  @override
  Stream<PlayingMoviesState> mapEventToState(
    PlayingMoviesEvent event,
  ) async* {
    if(event is FetchPlayingMovies)
    {
      yield LoadingState();
      try{
        MovieResponse response =await repo.getPopularMovies(page:event.page);
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
