import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/CastsBloc/casts_bloc.dart';
import 'package:movies/Models/CastResonse.dart';
import 'package:movies/Style/theme.dart' as style;

class CastsWidget extends StatefulWidget {
  int movieId;
  CastsWidget({Key key, this.movieId}) : super(key: key);
  @override
  _CastsWidgetState createState() => _CastsWidgetState();
}
class _CastsWidgetState extends State<CastsWidget> {
  @override
  Widget build(BuildContext context) {
    _fetchHomeData(context, widget.movieId);
    return  BlocBuilder<CastsBloc, CastsState>(
        builder: (BuildContext context, CastsState state) {
          if (state is ErrorStateCasts) {
            return Text("Error happened");
          }
          if (state is LoadedStateCasts) {
            return _buildCastWidget(state.casts);
          }
          return Container();
        });
  }

  void _fetchHomeData(BuildContext context, movieId)
  {
    FetchCastsDetails castEvent = FetchCastsDetails(movieId: movieId);
    BlocProvider.of<CastsBloc>(context).add(castEvent);
  }

  Widget _buildCastWidget(CastResponse casts)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(
                "Casts",
                style: TextStyle(
                    height: 1.5, fontSize: 12.0, color:style.Themes.titleColor,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height:10),
            Container(
              height: 150.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: casts.casts.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {

                    return Container(
                      width: 100.0,
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          casts.casts.elementAt(index).image != null
                              ? Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: style.Themes.secoundColor,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/${casts.casts.elementAt(index).image}",
                                  ),
                                  fit: BoxFit.cover,
                                )),
                          )
                              : Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: style.Themes.secoundColor,
                              ),
                              child: Icon(FontAwesomeIcons.userAlt)),
                          SizedBox(height: 10.0),
                          Text(
                            casts.casts.elementAt(index).name,
                            maxLines: 2,
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            "${casts.casts.elementAt(index).charachter}",
                            maxLines: 1,
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 8.0,
                                fontWeight: FontWeight.w400,
                                color: style.Themes.titleColor
                            ),
                          )


                        ],
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
}