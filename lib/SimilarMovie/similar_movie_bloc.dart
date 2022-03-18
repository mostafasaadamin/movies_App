import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'similar_movie_event.dart';
part 'similar_movie_state.dart';

class SimilarMovieBloc extends Bloc<SimilarMovieEvent, SimilarMovieState> {
  SimilarMovieBloc() : super(SimilarMovieInitial());
  MovieRepository repo=MovieRepository();
  List<Movie> movies;
  @override
  Stream<SimilarMovieState> mapEventToState(
    SimilarMovieEvent event,
  ) async* {
    if(event is FetchMoviesSimilar)
    {
      yield LoadingStateSimilar();
      try{
        MovieResponse response =await repo.getSimilarMovie(page:event.page,movieId: event.movieId);
        if(response!=null)
          yield LoadedStateSimilar(movieList: response.movies);
        else
          yield ErrorStateSimilar(error: "NO data  Found");
      }on SocketException {
        yield ErrorStateSimilar(error: 'No Internet',);
      } on HttpException {
        yield ErrorStateSimilar(error: 'No Service Found',);
      } on FormatException {
        yield ErrorStateSimilar(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorStateSimilar(error: 'Unknown Error',);
      }
    }
  }
}
