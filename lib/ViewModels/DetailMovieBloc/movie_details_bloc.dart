import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Date/Models/MovieDetails.dart';
import 'package:movies/Date/Repository/MovieRepository.dart';
import 'package:movies/ViewModels/DetailMovieBloc/movie_details_event.dart';
import 'package:movies/ViewModels/DetailMovieBloc/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial());
  MovieRepository repo=MovieRepository();
  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    if(event is FetchMovieDetails)
    {
      yield LoadingState();
      try{
        MovieDetails response =await repo.getMovieDetails(id:event.movieId);
        if(response!=null) {
          yield LoadedState(movie: response);
        }
        else yield ErrorState(error: "NO data  Found");
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
