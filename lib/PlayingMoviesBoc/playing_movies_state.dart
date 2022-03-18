part of 'playing_movies_bloc.dart';

abstract class PlayingMoviesState extends Equatable {
  const PlayingMoviesState();
  @override
  List<Object> get props => [];
}

class PlayingMoviesInitial extends PlayingMoviesState {
}

class LoadingState extends PlayingMoviesState {}
class LoadedState extends PlayingMoviesState
{
  final List<Movie> movieList;
  LoadedState({@required this.movieList});
}
class ErrorState extends PlayingMoviesState
{
  final  String error;
  ErrorState({@ required this.error});
}