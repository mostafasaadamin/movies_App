import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/Date/Models/Movie.dart';
import 'package:movies/ViewModels/MoviesVideosBloc/movies_videos_bloc.dart';
import 'package:movies/Style/theme.dart' as style;
import 'package:movies/Presentation/Widgets/casts_widget.dart';
import 'package:movies/Presentation/Widgets/movie_info.dart';
import 'package:movies/Presentation/Widgets/video_player_widget.dart';
import 'package:movies/ViewModels/MoviesVideosBloc/movies_videos_event.dart';
import 'package:movies/ViewModels/MoviesVideosBloc/movies_videos_state.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsMovieScreen extends StatefulWidget {
  Movie movie;
  DetailsMovieScreen({@required this.movie});
  @override
  _DetailsMovieScreenState createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  @override
  Widget build(BuildContext context) {
    _fetchHomeData(context, widget.movie.id);
    return Scaffold(
      backgroundColor: style.Themes.mainColor,
      body: Builder(
        builder: (context) => SliverFab(
          floatingWidget:
          BlocBuilder<MoviesVideosBloc, MoviesVideosState>(
              builder: (BuildContext context, MoviesVideosState state) {
            if (state is ErrorStateVideos) {
              return Text("Error happened"+state?.error);
            }
            if (state is LoadedStateVideos) {
              return state.videosList.length>0?
                FloatingActionButton(
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoPlayerWidget(youtubeKey: state.videosList[0].key,)),
                  );
                },
                backgroundColor: style.Themes.secoundColor,
                child: Icon(
                  EvaIcons.playCircle,
                  size: 30,
                ),
              ):Container();
            }
            return Center(child: CircularProgressIndicator());
          }),
          floatingPosition: FloatingPosition(right: 16.w),
          expandedHeight: 220.0.h,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 220.h,
              backgroundColor: style.Themes.mainColor,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.movie.title.length > 40
                      ? widget.movie.title.substring(0, 38) + "..."
                      : widget.movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0.sp),
                ),
                background: Stack(
                  children: [
                    Container(
                      height: 250.h,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        height: 250.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://image.tmdb.org/t/p/original/${widget.movie.backPoster}",
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(10.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding:  EdgeInsets.only(left: 10.0.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.movie.rating.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white),
                      ),
                      SizedBox(width: 8.0),
                      RatingBar.builder(
                        minRating: 1,
                        onRatingUpdate: (value){},
                        ignoreGestures: true,
                        itemSize: 10.0,
                        initialRating: widget.movie.rating,
                        allowHalfRating: false,
                        itemCount: 10,
                        direction: Axis.horizontal,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) {
                          return Icon(EvaIcons.star,
                              color: style.Themes.secoundColor);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 20.0.h, left: 10.0.w),
                  child: Text(
                    "OverView",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0.sp,
                        color: style.Themes.titleColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.movie.overview,
                    style: TextStyle(
                        height: 1.5, fontSize: 12.0.sp, color: Colors.white),
                  ),
                ),
                 SizedBox(height:10.0.h),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     MovieInfo(movieId: widget.movie.id),
                   ],
                 ),
                 SizedBox(height:10.0.h),
                 CastsWidget(movieId: widget.movie.id),
              ])),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchHomeData(BuildContext context, int movieId) {
    //fetch videos for movies data bloc
    MoviesVideosEvent videos = FetchMoviesVideos(movieId: movieId);
    BlocProvider.of<MoviesVideosBloc>(context).add(videos);
  }
}
