import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movies/Date/Models/MovieDetails.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object> get props => [];
}
class MovieDetailsInitial extends MovieDetailsState {

}
class LoadingState extends MovieDetailsState {}
class LoadedState extends MovieDetailsState {
  final MovieDetails movie;
  LoadedState({@required this.movie});
}
class ErrorState extends MovieDetailsState {
  final  String error;
  ErrorState({@required this.error});
}