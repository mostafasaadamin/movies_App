import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'package:movies/Date/Models/MovieResonse.dart';

import 'package:movies/Date/Repository/MovieRepository.dart';
import 'package:movies/ViewModels/use_cases/hive_operation.dart';

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
        if(response!=null) {
          if(response.movies.isNotEmpty){
            HiveOperations.getInstance().insertIntoHive(response.movies);
          }
          yield LoadedState(
              movieList: response.movies, totalPage: response.totalPages);
        }
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

    }else if (event is FetchSavedMoviesResult){
      yield LoadingState();
      try{
List<Movie> movies=await HiveOperations.getInstance().readSavedMovies();
print("MoviesSizeIS${movies.length}");
        if(movies.isNotEmpty)
          yield LoadedSavedSearchState(movieList: movies,totalPage: 1);
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
