import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc() : super(PopularMoviesInitial());
  MovieRepository repo=MovieRepository();
  List<Movie> movies;
  @override
  Stream<PopularMoviesState> mapEventToState( PopularMoviesEvent event,) async* {
    if(event is FetchPopularMovies)
    {
      yield LoadingStatePopular();
      try{
        MovieResponse response =await repo.getPopularMovies(page:event.page);
        if(response!=null)
          yield LoadedStatePopular(movieList: response.movies);
        else
          yield ErrorStatePopular(error: "NO data  Found");
      }on SocketException {
        yield ErrorStatePopular(error: 'No Internet',);
      } on HttpException {
        yield ErrorStatePopular(error: 'No Service Found',);
      } on FormatException {
        yield ErrorStatePopular(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorStatePopular(error: 'Unknown Error',);
      }
    }
  }
  }
