
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props =>[];
}
class FetchMovies extends MoviesEvent
{
  int page;
  FetchMovies({@required this.page});
}