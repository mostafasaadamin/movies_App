part of 'search_movie_bloc.dart';


abstract class SearchMovieEvent extends Equatable {
  @override
  List<Object> get props =>[];
}
class FetchSearchedMovies extends SearchMovieEvent
{
  int page;
  String searchMovie;
  FetchSearchedMovies({@required this.page,@required this.searchMovie});
}