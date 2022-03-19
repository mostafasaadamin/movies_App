import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hive/hive.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'package:movies/ViewModels/MovieBloc/movies_bloc.dart';
import 'package:movies/ViewModels/MoviesVideosBloc/movies_videos_bloc.dart';
import 'package:movies/Presentation/Screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'ViewModels/CastsBloc/casts_bloc.dart';
import 'ViewModels/DetailMovieBloc/movie_details_bloc.dart';
import 'ViewModels/searchMoviesBloc/search_movie_bloc.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieAdapter());
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
          BlocProvider(create: (context) => SearchMovieBloc()),


        ],
        child:  ScreenUtilInit(
          builder:()=> MaterialApp(
            locale: Locale("en",''),
            debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    ),
        ));
  }
}


