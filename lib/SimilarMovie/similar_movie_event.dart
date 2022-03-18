part of 'similar_movie_bloc.dart';

abstract class SimilarMovieEvent extends Equatable {
  const SimilarMovieEvent();
  @override
  List<Object> get props =>[];
}
class FetchMoviesSimilar extends SimilarMovieEvent
{
  int page;
  int movieId;
  FetchMoviesSimilar({@required this.page,@required this.movieId});
}