import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/DetailMovieBloc/movie_details_bloc.dart';
import 'package:movies/Models/MovieDetails.dart';
import 'package:movies/Style/theme.dart' as style;

class MovieInfo extends StatefulWidget {
  int movieId;
  MovieInfo({this.movieId});

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    _fetchHomeData(context, widget.movieId);
    return
      BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (BuildContext context, MovieDetailsState state) {
            if (state is ErrorState) {
              return Text("Error happened");
            }
            if (state is LoadedState) {
              return _buildMovieInfoWidget(state.movie);


            }
            return Center(child: CircularProgressIndicator());
          });
  }

  Widget _buildMovieInfoWidget(MovieDetails movie)
  {
return Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(
           children: [
             Text(
               "BUDGET",
               style: TextStyle(
                   height: 1.5, fontSize: 12.0, color:style.Themes.titleColor,
                 fontWeight: FontWeight.w500
               ),
             ),
             SizedBox(height: 10.0,),
             Text(
               movie.budget.toString()+"\$",
               style: TextStyle(
                   height: 1.5, fontSize: 12.0, color:style.Themes.secoundColor,
                   fontWeight: FontWeight.bold
               ),
             ),
           ],
         ),
          Column(
            children: [
              Text(
                "DURATION",
                style: TextStyle(
                    height: 1.5, fontSize: 12.0, color:style.Themes.titleColor,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                movie.runtime.toString()+"minute",
                style: TextStyle(
                    height: 1.5, fontSize: 12.0, color:style.Themes.secoundColor,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "RELEASE DATE",
                style: TextStyle(
                    height: 1.5, fontSize: 12.0, color:style.Themes.titleColor,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                movie.releaseDate,
                style: TextStyle(
                    height: 1.5, fontSize: 12.0, color:style.Themes.secoundColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height:10.0),

            ],
          )
        ],
      ),

    ),
    SizedBox(height:10),
    Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:10.0),
          child: Text(
            "GENRE",
            style: TextStyle(
                height: 1.5, fontSize: 12.0, color:style.Themes.titleColor,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        SizedBox(height:10),
        Container(
          height: 50.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.genres.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index)
              {
                return Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Chip(
                    label:  Text(
                      movie.genres.elementAt(index).name,
                      style: TextStyle(
                          height: 1.5, fontSize: 12.0, color:Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    elevation: 2.0,
                    labelPadding: EdgeInsets.only(left:5.0,right: 5.0),
                    avatar: CircleAvatar(
                      backgroundImage: AssetImage("asset/img/avatat.jpg"),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    ),

  ],
);
  }

  void _fetchHomeData(BuildContext context, int movieId)
  {
    FetchMovieDetails movieDetial = FetchMovieDetails(movieId: movieId);
    BlocProvider.of<MovieDetailsBloc>(context).add(movieDetial);

  }
}