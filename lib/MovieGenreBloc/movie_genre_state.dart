part of 'movie_genre_bloc.dart';

abstract class MovieGenreState extends Equatable {
  const MovieGenreState();
  @override
  List<Object> get props => [];
}

class MovieGenreInitial extends MovieGenreState {}
class LoadingState extends MovieGenreState {}
class LoadedState extends MovieGenreState
{
  final List<Movie> movieList;
  LoadedState({@required this.movieList});
}
class ErrorState extends MovieGenreState
{
  final  String error;
  ErrorState({@ required this.error});
}