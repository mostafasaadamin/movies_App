import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMoviesState> {
  SearchMovieBloc() : super(SearchMoviesInitial());
  MovieRepository repo=MovieRepository();
  List<Movie> movies;
  @override
  Stream<SearchMoviesState> mapEventToState(SearchMovieEvent event,) async* {
    if(event is FetchSearchedMovies)
    {
      yield LoadingState();
      try{
        MovieResponse response =await repo.searchForMovies(page:event.page,searchedMovie: event.searchMovie);
        print("data${response.movies.length}");
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
    }else if (event is FetchSearchedMoviesPaging){
      yield LoadingStatePaging();
      try{
        MovieResponse response =await repo.searchForMovies(page:event.page,searchedMovie: event.searchMovie);
        print("data${response.movies.length}");
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
