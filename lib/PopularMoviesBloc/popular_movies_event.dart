part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props =>[];
}
class FetchPopularMovies extends PopularMoviesEvent
{
  int page;
  FetchPopularMovies({@required this.page});
}
