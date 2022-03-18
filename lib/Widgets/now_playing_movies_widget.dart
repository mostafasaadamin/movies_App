import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Screens/details_movie_screen.dart';
import 'package:movies/Style/theme.dart' as style;
class nowPlayingMoviesWidget extends StatelessWidget {
  List<Movie> movies;
  nowPlayingMoviesWidget({@required this.movies});
  @override
  Widget build(BuildContext context) {
    return movies.length == 0
        ? _noMoviesWidget(context)
        : _nowPlayingMoviesList(movies);
  }

  Widget _noMoviesWidget(BuildContext context) {
    return Container(
      height: 228,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
          image: new DecorationImage(
        image: new AssetImage("asset/img/no_data.jpg"),
        fit: BoxFit.cover,
      )),
    );
  }

  Widget _nowPlayingMoviesList(List<Movie> moviesList) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 228,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayInterval: Duration(seconds: 4),
          pageSnapping: true,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          aspectRatio: 2.0),
      items: moviesList.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsMovieScreen(movie: movie,)),
                );
              },
              child: Stack(
                children: [
                  Container(
                    color:style.Themes.secoundColor,
                    height: 228,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      height: 228,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: "https://image.tmdb.org/t/p/original/${movie.backPoster}",

                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
style.Themes.mainColor.withOpacity(1.0),
                          style.Themes.mainColor.withOpacity(0.0),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                        stops: [
                         0.0,
                          0.9
                        ]
                      )
                    ),

                  ),
                  Positioned(
                    bottom: 10.0,
                    child:Container(
                      width:250.0,
                      padding: EdgeInsets.only(left:10.0,right:10.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
              movie.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                    height: 1.5

                  ),
              )
              ],
              )
                    )
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child:
                  Icon(FontAwesomeIcons.playCircle,color:style.Themes.secoundColor,size: 40.0,)
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
