part of 'search_movie_bloc.dart';
abstract class SearchMoviesState extends Equatable {
    MoviesState();
  @override
  List<Object> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {
  @override
  MoviesState() {
    // TODO: implement MoviesState
    throw UnimplementedError();
  }
}
class LoadingState extends SearchMoviesState {
  @override
  MoviesState() {
    // TODO: implement MoviesState
    throw UnimplementedError();
  }
}
class LoadingStatePaging extends SearchMoviesState {
  @override
  MoviesState() {
    // TODO: implement MoviesState
    throw UnimplementedError();
  }
}
class LoadedState extends SearchMoviesState
{
  final List<Movie> movieList;
  int totalPage;
  LoadedState({@required this.movieList,@required this.totalPage});

  @override
  MoviesState() {
    // TODO: implement MoviesState
    throw UnimplementedError();
  }
}
class ErrorState extends SearchMoviesState
{
  final  String error;
  ErrorState({@ required this.error});

  @override
  MoviesState() {
    // TODO: implement MoviesState
    throw UnimplementedError();
  }
}