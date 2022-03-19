import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'package:movies/Presentation/Screens/details_movie_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies/Style/theme.dart' as style;
class MovieCard extends StatelessWidget {
  Movie movie;

  MovieCard({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsMovieScreen(movie: movie,)),
        );
      },
      child: Card(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            right: 0,
          ),
          child: Row(
            children: [
              movie.poster == null
                  ? Container(
                width: 120.0.w,
                height: 100.0.h,
                      decoration: BoxDecoration(
                          color: style.Themes.secoundColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            EvaIcons.filmOutline,
                            color: Colors.white,
                            size: 50.0,
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: 120.0.w,
                      height: 100.0.h,
                      decoration: BoxDecoration(
                          color: style.Themes.secoundColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200/${movie.poster}",
                              ),
                              fit: BoxFit.cover))),
              SizedBox(width: 10.0.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140.0.w,
                    child: Text(
                      movie.title??""
                      ,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Row(
                    children: [

                      RatingBar.builder(
                        minRating: 1,
                        itemSize: 10.0,
                        initialRating: movie.rating,
                        allowHalfRating: false,
                        itemCount: 10,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        glowColor: Colors.white,
                        unratedColor: Colors.grey,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) {
                          return Icon(EvaIcons.star,
                              color: style.Themes.secoundColor);
                        },
                        onRatingUpdate: (rating)
                        {
                          print(rating);
                        },
                      ),
                      SizedBox(width: 2.0),

                      Text(
                        " ( ${movie.rating.toString()} ) ",
                        style: TextStyle(
                            fontSize: 10.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Text(
                    movie.releaseDate??"",
                    style: TextStyle(
                        fontSize: 10.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                      movie.overview??"",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0.sp),
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
