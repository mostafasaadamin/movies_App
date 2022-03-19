import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/ViewModels/CastsBloc/casts_bloc.dart';
import 'package:movies/Date/Models/CastResonse.dart';
import 'package:movies/Style/theme.dart' as style;
import 'package:movies/ViewModels/CastsBloc/casts_state.dart';
import 'package:movies/ViewModels/CastsBloc/casts_event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            return Text("Error happened"+state?.error);
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
              padding:  EdgeInsets.only(left:10.0.w),
              child: Text(
                "Casts",
                style: TextStyle(
                    height: 1.5, fontSize: 12.0.sp, color:style.Themes.titleColor,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height:10.h),
            Container(
              height: 150.0.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: casts.casts.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {

                    return Container(
                      width: 100.0.w,
                      padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, top: 10.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          casts.casts.elementAt(index).image != null
                              ? Container(
                            width: 70.0.w,
                            height: 70.0.h,
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
                              width: 70.0.w,
                              height: 70.0.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: style.Themes.secoundColor,
                              ),
                              child: Icon(FontAwesomeIcons.userAlt)),
                          SizedBox(height: 10.0.h),
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
                          SizedBox(height: 3.0.h),
                          Text(
                            "${casts.casts.elementAt(index).charachter}",
                            maxLines: 1,
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 8.0.sp,
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