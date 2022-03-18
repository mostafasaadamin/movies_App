part of 'similar_movie_bloc.dart';

abstract class SimilarMovieState extends Equatable {
  const SimilarMovieState();
  @override
  List<Object> get props => [];
}

class SimilarMovieInitial extends SimilarMovieState {

}
class LoadingStateSimilar extends SimilarMovieState {}
class LoadedStateSimilar extends SimilarMovieState {
  final List<Movie> movieList;
  LoadedStateSimilar({@required this.movieList});
}
class ErrorStateSimilar extends SimilarMovieState {
  final  String error;
  ErrorStateSimilar({@required this.error});
}