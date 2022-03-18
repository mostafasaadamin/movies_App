import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Screens/details_movie_screen.dart';
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
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 10,
        ),
        child: Column(
          children: [
            movie.poster == null
                ? Container(
                    width: 180.0,
                    height: 120.0,
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
                    width: 180.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: style.Themes.secoundColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/w200/${movie.poster}",
                            ),
                            fit: BoxFit.cover))),
            SizedBox(height: 10.0),
            Container(
              width: 100.0,
              child: Text(
                movie.title,
                maxLines: 2,
                style: TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  movie.rating.toString(),
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(width: 10.0),
                RatingBar.builder(
                    minRating: 1,
                    itemSize: 10.0,
                    initialRating: movie.rating,
                    allowHalfRating: false,
                    itemCount: 10,
                    direction: Axis.horizontal,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) {
                      return Icon(EvaIcons.star,
                          color: style.Themes.secoundColor);
                    },
                  // onRatingUpdate: (rating)
                  // {
                  //   print(rating);
                  // },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
