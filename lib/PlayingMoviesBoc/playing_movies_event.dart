part of 'playing_movies_bloc.dart';

abstract class PlayingMoviesEvent extends Equatable {
  const PlayingMoviesEvent();

  @override
  List<Object> get props =>[];
}
class FetchPlayingMovies extends PlayingMoviesEvent
{
  int page;
  FetchPlayingMovies({@required this.page});
}