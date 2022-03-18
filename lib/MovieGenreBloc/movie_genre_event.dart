part of 'movie_genre_bloc.dart';

abstract class MovieGenreEvent extends Equatable {
  const MovieGenreEvent();

  @override
  List<Object> get props {
    return [];
  }
}
class FetchGenreMovies extends MovieGenreEvent
{
  int genreId;
  FetchGenreMovies({@required this.genreId});
}