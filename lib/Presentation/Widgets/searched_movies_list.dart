
import 'package:flutter/material.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'movie_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoviesList extends StatelessWidget {
  List<Movie> moviesList;
  List<Movie> allMoviesList;
  ScrollController controller;
  MoviesList({this.moviesList, this.allMoviesList,this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom:180.0.h),
      child: ListView.builder(
          controller: controller,
          scrollDirection: Axis.vertical,
          itemCount: allMoviesList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index)
          {
            if(index == allMoviesList.length-1&&moviesList.isNotEmpty){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50.w,
                      height: 50.h,
                      child: CircularProgressIndicator()),
                ],
              );
            }else if (index == allMoviesList.length-1&&moviesList.isEmpty){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child:Text("No more Data",style: TextStyle(color: Colors.white),)),
                  ),
                ],
              );

            }else{
              return MovieCard(movie: allMoviesList[index]);

            }
          }
      ),
    );
  }
}
