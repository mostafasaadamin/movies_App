import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/MovieBloc/movies_bloc.dart';
import 'package:movies/MoviesVideosBloc/movies_videos_bloc.dart';
import 'package:movies/Screens/home_screen.dart';
import 'CastsBloc/casts_bloc.dart';
import 'DetailMovieBloc/movie_details_bloc.dart';
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
          BlocProvider(create: (context) => MovieDetailsBloc()),
          BlocProvider(create: (context) => CastsBloc()),
          BlocProvider(create: (context) => MoviesVideosBloc()),


        ],
        child: MaterialApp(
          locale: Locale("en",''),
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


