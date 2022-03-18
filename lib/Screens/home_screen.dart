import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/GenresBloc/genres_bloc.dart';
import 'package:movies/Models/Genre.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Models/Person.dart';
//import 'package:movies/MovieBloc/movies_bloc.dart';
import 'package:movies/PersonBloc/persons_bloc.dart';
import 'package:movies/PlayingMoviesBoc/playing_movies_bloc.dart';
import 'package:movies/PopularMoviesBloc/popular_movies_bloc.dart';
import 'package:movies/Style/theme.dart' as style;
import 'package:movies/Widgets/movie_card.dart';
import 'package:movies/Widgets/now_playing_movies_widget.dart';
import 'package:movies/Widgets/persons_widget.dart';
import 'package:movies/Widgets/tab_bar_items.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
 bool isConnected=true;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Connectivity _connectivity = Connectivity();
   StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print("result${result.toString()}");
    switch (result) {
      case ConnectivityResult.wifi:
        widget.isConnected=true;
        break;
      case ConnectivityResult.mobile:
        widget.isConnected=true;
        break;
      case ConnectivityResult.none:
         widget.isConnected=false;
        break;
      default:
       widget.isConnected=false;
        break;

    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    _fetchHomeData(context);
    return widget.isConnected? Scaffold(
      backgroundColor: style.Themes.mainColor,
      appBar: AppBar(
        backgroundColor: style.Themes.mainColor,
        centerTitle: true,
        title: Text("Movies"),
        leading: Icon(EvaIcons.menu2Outline,color:Colors.white),
        actions: [
          IconButton(
            icon: Icon(EvaIcons.searchOutline,color:Colors.white),
            onPressed: null,
          )
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left:12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height:228 ,
                child: BlocBuilder<PlayingMoviesBloc, PlayingMoviesState>(
                    builder: (BuildContext context, PlayingMoviesState state) {
                      if (state is ErrorState) {
                        return nowPlayingMoviesWidget(movies: []);
                      }
                      if (state is LoadedState) {
                        List<Movie> moviesList = state.movieList;
                        return nowPlayingMoviesWidget(movies: moviesList);
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
              SizedBox(height:10),
              Container(
             height: 300.0,
                child: BlocBuilder<GenresBloc, GenresState>(
                    builder: (BuildContext context, GenresState state) {
                      if (state is ErrorStateGenres) {
                     //   return nowPlayingMoviesWidget(movies: []);
                      }
                      if (state is LoadedStateGenres) {
                        print("GenreList${state.genresList.length}");
                        List<Genre> genreList = state.genresList;
                        return TabBarItems(genreList: genreList);
                      }else
                        {
                        return Center(child: CircularProgressIndicator());
                        }
                    }),
              ),
              SizedBox(height:10),
              Text("Trending persons this week",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white
              ),),
              SizedBox(height:10),
              Container(
                height: 200.0,
                child: BlocBuilder<PersonsBloc, PersonsState>(
                    builder: (BuildContext context, PersonsState state) {
                      if (state is ErrorStatePersons) {

                      }
                      if (state is LoadedStatePersons) {
                        List<Person> persons = state.persons;
                        return
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: persons.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index)
                              {
                                return PersonsWidget(person: persons[index]);
                              }
                          );
                      }else
                      {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              Text("Top Rated Movies",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white
              ),),
              SizedBox(height:10),
          Container(
            height: 300.0,
            child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (BuildContext context, PopularMoviesState state) {
                  if (state is ErrorStatePopular) {
                    //   return nowPlayingMoviesWidget(movies: []);
                  }
                  if (state is LoadedStatePopular) {
                    List<Movie> movies = state.movieList;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index)
                        {
                          return MovieCard(movie: movies[index]);
                        }
                    );
                  }else
                  {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
            ],
          ),
        ),
      )

          
    ):
Scaffold(
  backgroundColor: Colors.white,
  body: Center(
    child: Image.asset("asset/img/nointernet.jpg"),
  )
);



  }
//method for fetch movies data
  void _fetchHomeData(BuildContext context)
  {
    FetchPlayingMovies movies=FetchPlayingMovies(page: 1);
    FetchGenres genres=FetchGenres(page: 1);
    FetchPersons persons=FetchPersons();
    FetchPopularMovies popularMovies=FetchPopularMovies(page: 1);
    BlocProvider.of<PlayingMoviesBloc>(context).add(movies);
    BlocProvider.of<GenresBloc>(context).add(genres);
    BlocProvider.of<PersonsBloc>(context).add(persons);
    BlocProvider.of<PopularMoviesBloc>(context).add(popularMovies);
  }
}