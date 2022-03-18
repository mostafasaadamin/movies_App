import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/SearchMoviesBloc/search_movie_bloc.dart';
import 'package:movies/Style/theme.dart' as style;
import 'package:movies/Widgets/movie_card.dart';
import 'package:movies/Widgets/search_bar.dart';
class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);
  bool isConnected=true;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SearchScreen> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final _controller = ScrollController();
int page=1;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
         page++;
         FetchSearchedMoviesPaging getMoviesEvent=FetchSearchedMoviesPaging(page:page,searchMovie: searchedText);
         BlocProvider.of<SearchMovieBloc>(context).add(getMoviesEvent);
      }
    });
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  String searchedText="";
  List<Movie> allMoviesList=[];
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
    // _fetchHomeData(context);
    return widget.isConnected? Scaffold(
        backgroundColor: style.Themes.mainColor,
        appBar: AppBar(
          backgroundColor: style.Themes.mainColor,
          centerTitle: true,
          title: Text("Searched Movies"),
        ),
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SearchBarWidget(typedText: (value){
                    allMoviesList.clear();
                    page=1;

                    _fetchSearchedMovieData(context: context,page:page,searchText: value);
                    searchedText=value;
                  },),
                ),
                SizedBox(height: 10,),
                Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  child: BlocBuilder<SearchMovieBloc, SearchMoviesState>(
                      builder: (BuildContext context, SearchMoviesState state) {
                        if (state is ErrorState) {
                          return Container();
                        }
                        if (state is LoadedState) {
                          print("GenreList${state.movieList.length}");
                          List<Movie> moviesList = state.movieList;
                          allMoviesList.addAll(moviesList);
                          return Padding(
                            padding: const EdgeInsets.only(bottom:100.0),
                            child: ListView.builder(
                              controller: _controller,
                                scrollDirection: Axis.vertical,
                                itemCount: allMoviesList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index)
                                {
                                  return MovieCard(movie: allMoviesList[index]);
                                }
                            ),
                          );
                        }else if(state is LoadingStatePaging){
                          return   Padding(
                            padding: const EdgeInsets.only(bottom:100.0),
                            child:ListView.builder(
                                controller: _controller,
                                scrollDirection: Axis.vertical,
                                itemCount: allMoviesList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index)
                                {
                                  return MovieCard(movie: allMoviesList[index]);
                                }
                            ),

                          );
                        } else
                        {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
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
  void _fetchSearchedMovieData({BuildContext context,int page=1,String searchText})
  {
    FetchSearchedMovies getMoviesEvent=FetchSearchedMovies(page:1,searchMovie: searchText);
    BlocProvider.of<SearchMovieBloc>(context).add(getMoviesEvent);
  }
}