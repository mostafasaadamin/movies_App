import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movies/Date/Models/Movie.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}
class LoadingState extends MoviesState {}
class LoadedState extends MoviesState
{
  final List<Movie> movieList;
  int totalPage;
  LoadedState({@required this.movieList,@required this.totalPage});
}
class ErrorState extends MoviesState
{
 final  String error;
  ErrorState({@ required this.error});
}