import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'package:movies/Date/Models/MovieResonse.dart';
import 'package:movies/Date/Repository/MovieRepository.dart';
import 'package:movies/ViewModels/MovieBloc/movies_event.dart';
import 'package:movies/ViewModels/MovieBloc/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial());
  MovieRepository repo=MovieRepository();
  List<Movie> movies;
  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event,) async* {
   if(event is FetchMovies)
   {
    yield LoadingState();
    try{
        MovieResponse response =await repo.getMovies(page:event.page);
        print("data${response.movies[0].title}");
        if(response!=null)
          yield LoadedState(movieList: response.movies,totalPage: response.totalPages);
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
