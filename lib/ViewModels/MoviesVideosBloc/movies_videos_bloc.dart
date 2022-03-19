


import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:movies/Date/Models/Video.dart';
import 'package:movies/Date/Models/VideoResonse.dart';
import 'package:movies/Date/Repository/MovieRepository.dart';
import 'package:movies/ViewModels/MoviesVideosBloc/movies_videos_event.dart';
import 'package:movies/ViewModels/MoviesVideosBloc/movies_videos_state.dart';

class MoviesVideosBloc extends Bloc<MoviesVideosEvent, MoviesVideosState> {
  MoviesVideosBloc() : super(MoviesVideosInitial());
  MovieRepository repo=MovieRepository();
  List<Video> videos;
  @override
  Stream<MoviesVideosState> mapEventToState(
    MoviesVideosEvent event,
  ) async* {
    if(event is FetchMoviesVideos)
    {
      yield LoadingStateVideos();
      try{
        VideoResponse response =await repo.getMovieVideos(movieId: event.movieId,page: 1);
        if(response!=null)
          yield LoadedStateVideos(videosList: response.videos);
        else
          yield ErrorStateVideos(error: "NO data  Found");
      }on SocketException {
        yield ErrorStateVideos(error: 'No Internet',);
      } on HttpException {
        yield ErrorStateVideos(error: 'No Service Found',);
      } on FormatException {
        yield ErrorStateVideos(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorStateVideos(error: 'Unknown Error',);
      }
    }  }
}
