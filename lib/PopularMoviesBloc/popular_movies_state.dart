part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();
}

class PopularMoviesInitial extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

class LoadingStatePopular extends PopularMoviesInitial {}
class LoadedStatePopular extends PopularMoviesInitial
{
  final List<Movie> movieList;
  LoadedStatePopular({@required this.movieList});
}
class ErrorStatePopular extends PopularMoviesInitial
{
  final  String error;
  ErrorStatePopular({@ required this.error});
}