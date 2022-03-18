part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
  @override
  List<Object> get props =>[];
}
class FetchMovieDetails extends MovieDetailsEvent
{
  int movieId;
  FetchMovieDetails({@required this.movieId});
}