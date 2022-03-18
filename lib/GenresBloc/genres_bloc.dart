import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/Genre.dart';
import 'package:movies/Models/GenreResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  GenresBloc() : super(GenresInitial());
  MovieRepository repo=MovieRepository();
  List<Genre> movies;
  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    if(event is FetchGenres)
    {
      yield LoadingState();
      try{
        GenreResonse response =await repo.getGenres(page:event.page);
        if(response!=null) {
          print("FromGenreBloc${response.Genres}");
          yield LoadedStateGenres(genresList: response.Genres);
        }
        else
          yield ErrorStateGenres(error: "NO data  Found");
      }on SocketException {
        yield ErrorStateGenres(error: 'No Internet',);
      } on HttpException {
        yield ErrorStateGenres(error: 'No Service Found',);
      } on FormatException {
        yield ErrorStateGenres(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorStateGenres(error: 'Unknown Error',);
      }
    }
  }
}
