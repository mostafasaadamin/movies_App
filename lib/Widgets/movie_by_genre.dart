import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/MovieGenreBloc/movie_genre_bloc.dart';
import 'package:movies/Widgets/movie_card.dart';

class MovieByGenre extends StatefulWidget {
  int genreId;
  MovieByGenre({ @required this.genreId});
  @override
  _MovieByGenreState createState() => _MovieByGenreState();
}

class _MovieByGenreState extends State<MovieByGenre> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _fetchMovieByGenre(context,widget.genreId);
    return  Container(
      height: 300.0,
      child: BlocBuilder<MovieGenreBloc, MovieGenreState>(
          builder: (BuildContext context, MovieGenreState state) {
            if (state is ErrorState) {
              //   return nowPlayingMoviesWidget(movies: []);
            }
            if (state is LoadedState) {
              print("GenreList${state.movieList.length}");
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
    );
  }
  void _fetchMovieByGenre(BuildContext context, int genreId)
  {
    print("genreIdFromMethod$genreId");
    FetchGenreMovies movieGenre=FetchGenreMovies(genreId: genreId);
    BlocProvider.of<MovieGenreBloc>(context).add(movieGenre);
  }
}