part of 'movies_videos_bloc.dart';

abstract class MoviesVideosState extends Equatable {
  const MoviesVideosState();
  @override
  List<Object> get props => [];
}

class MoviesVideosInitial extends MoviesVideosState {

}
class LoadingStateVideos extends MoviesVideosState {

}
class LoadedStateVideos extends MoviesVideosState
{
  final List<Video> videosList;
  LoadedStateVideos({@required this.videosList});
}
class ErrorStateVideos extends MoviesVideosState
{
  final  String error;
  ErrorStateVideos({@ required this.error});
}