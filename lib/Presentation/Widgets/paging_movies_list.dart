
import 'package:flutter/material.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'movie_card.dart';

class PagingMoviesList extends StatelessWidget {
  List<Movie> allMoviesList;
  ScrollController controller;
  PagingMoviesList({this.allMoviesList,this.controller});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: allMoviesList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index)
        {
          return MovieCard(movie: allMoviesList[index]);
        }
    );
  }
}
