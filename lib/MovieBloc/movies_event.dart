part of 'movies_bloc.dart';

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