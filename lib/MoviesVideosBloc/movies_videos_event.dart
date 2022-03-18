part of 'movies_videos_bloc.dart';

abstract class MoviesVideosEvent extends Equatable {
  const MoviesVideosEvent();
  @override
  List<Object> get props {
    return [];
  }
}
class FetchMoviesVideos extends MoviesVideosEvent
{
  int movieId;
  FetchMoviesVideos({@required this.movieId});
}