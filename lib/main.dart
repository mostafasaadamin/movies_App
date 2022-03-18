import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/GenresBloc/genres_bloc.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/MovieBloc/movies_bloc.dart';
import 'package:movies/MovieGenreBloc/movie_genre_bloc.dart';
import 'package:movies/MoviesVideosBloc/movies_videos_bloc.dart';
import 'package:movies/PersonBloc/persons_bloc.dart';
import 'package:movies/PlayingMoviesBoc/playing_movies_bloc.dart';
import 'package:movies/PopularMoviesBloc/popular_movies_bloc.dart';
import 'package:movies/Repository/MovieRepository.dart';
import 'package:movies/Screens/home_screen.dart';

import 'CastsBloc/casts_bloc.dart';
import 'DetailMovieBloc/movie_details_bloc.dart';
import 'SimilarMovie/similar_movie_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MoviesBloc()),
          BlocProvider(create: (context) => MovieGenreBloc()),
          BlocProvider(create: (context) => PersonsBloc()),
          BlocProvider(create: (context) => PlayingMoviesBloc()),
          BlocProvider(create: (context) => PopularMoviesBloc()),
          BlocProvider(create: (context) => GenresBloc()),
          BlocProvider(create: (context) => MovieDetailsBloc()),
          BlocProvider(create: (context) => CastsBloc()),
          BlocProvider(create: (context) => SimilarMovieBloc()),
          BlocProvider(create: (context) => MoviesVideosBloc()),


        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    ));
  }
}


