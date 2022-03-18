part of 'movies_bloc.dart';

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
  LoadedState({@required this.movieList});
}
class ErrorState extends MoviesState
{
 final  String error;
  ErrorState({@ required this.error});
}