import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/SimilarMovie/similar_movie_bloc.dart';
import 'package:movies/Widgets/movie_card.dart';
import 'package:movies/Style/theme.dart' as style;
class SimilarMovieWidget extends StatefulWidget {
  int movieId;
  SimilarMovieWidget({Key key, this.movieId}) : super(key: key);
  @override
  _SimilarMovieWidgetState createState() => _SimilarMovieWidgetState();
}

class _SimilarMovieWidgetState extends State<SimilarMovieWidget> {
  @override
  Widget build(BuildContext context) {
    _fetchHomeData(context, widget.movieId);
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Text(
          "Similar Movies",
          style: TextStyle(
              height: 1.5, fontSize: 12.0, color:style.Themes.titleColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      SizedBox(height:10),
      Container(
          height: 270.0,
          child: BlocBuilder<SimilarMovieBloc, SimilarMovieState>(
              builder: (BuildContext context, SimilarMovieState state) {
                if (state is ErrorStateSimilar) {
                  //   return nowPlayingMoviesWidget(movies: []);
                }
                if (state is LoadedStateSimilar) {
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
                  return Container();
                }
              }),
        ),
    ],
  );
  }

  void _fetchHomeData(BuildContext context, int movieId) {
    FetchMoviesSimilar similarMovies = FetchMoviesSimilar(movieId: movieId, page: 1);
    BlocProvider.of<SimilarMovieBloc>(context).add(similarMovies);
  }
}