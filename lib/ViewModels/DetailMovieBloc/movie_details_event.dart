import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
  @override
  List<Object> get props =>[];
}
class FetchMovieDetails extends MovieDetailsEvent
{
  int movieId;
  FetchMovieDetails({@required this.movieId});
}