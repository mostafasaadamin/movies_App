import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'package:movies/ViewModels/searchMoviesBloc/search_movie_bloc.dart';
import 'package:movies/Style/theme.dart' as style;
import 'package:movies/Presentation/Widgets/movie_card.dart';
import 'package:movies/Presentation/Widgets/paging_movies_list.dart';
import 'package:movies/Presentation/Widgets/search_bar.dart';
import 'package:movies/Presentation/Widgets/searched_movies_list.dart';
import 'package:movies/ViewModels/use_cases/hive_operation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);
  bool isConnected=true;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SearchScreen> {
  final _controller = ScrollController();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int page=1;
  int totalPages=1;
  @override
  void initState() {
    super.initState();
    initScrollListener();
    FetechSavedSearchedResults();
  }
  String searchedText="";
  List<Movie> allMoviesList=[];
  @override
  Widget build(BuildContext context) {
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
            padding:  EdgeInsets.only(left:12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.all(10.0.h),
                  child: SearchBarWidget(typedText: (value){
                    allMoviesList.clear();
                    page=1;
                    _fetchSearchedMovieData(context: context,page:page,searchText: value);
                    searchedText=value;
                  },),
                ),
                SizedBox(height: 10.h,),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: BlocBuilder<SearchMovieBloc, SearchMoviesState>(
                      builder: (BuildContext context, SearchMoviesState state) {
                        if (state is ErrorState) {
                          return Container();
                        }
                        if (state is LoadedState) {
                          List<Movie> moviesList = state.movieList;
                          totalPages=state.totalPage;
                          allMoviesList.addAll(moviesList);
                          if(moviesList.isNotEmpty){
                            HiveOperations.getInstance().removeData();
                            HiveOperations.getInstance().insertIntoHive(moviesList);
                          }
                          return MoviesList(controller: _controller,allMoviesList: allMoviesList,moviesList:moviesList,);
                        }else if(state is LoadingStatePaging){
                          return  PagingMoviesList(controller:_controller ,allMoviesList:allMoviesList,);
                        } else if(state is LoadingState)
                        {
                          return Center(child: CircularProgressIndicator());
                        }else{
                          return Container();
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
  void _fetchSearchedMovieData({BuildContext context,int page=1,String searchText}) {
    FetchSearchedMovies getMoviesEvent=FetchSearchedMovies(page:1,searchMovie: searchText);
    BlocProvider.of<SearchMovieBloc>(context).add(getMoviesEvent);
  }
  void initScrollListener() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if(page<=totalPages){
        page++;
        FetchSearchedMoviesPaging getMoviesEvent=FetchSearchedMoviesPaging(page:page,searchMovie: searchedText);
        BlocProvider.of<SearchMovieBloc>(context).add(getMoviesEvent);
        }
      }
    });
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
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
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  void FetechSavedSearchedResults() {
    FetchSavedMoviesResult getMoviesEvent=FetchSavedMoviesResult();
    BlocProvider.of<SearchMovieBloc>(context).add(getMoviesEvent);
  }
}