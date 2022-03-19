
import 'package:flutter/material.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'movie_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedMoviesList extends StatelessWidget {
  List<Movie> allMoviesList;
  SavedMoviesList({this.allMoviesList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom:100.0.h),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: allMoviesList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index)
          {
            return MovieCard(movie: allMoviesList[index]);

          }
      ),
    );
  }
}
