
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MoviesVideosEvent extends Equatable {
  const MoviesVideosEvent();
  @override
  List<Object> get props {
    return [];
  }
}
class FetchMoviesVideos extends MoviesVideosEvent
{
  int movieId;
  FetchMoviesVideos({@required this.movieId});
}