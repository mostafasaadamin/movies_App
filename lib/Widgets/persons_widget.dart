import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/Models/Person.dart';
import 'package:movies/Style/theme.dart' as style;

class PersonsWidget extends StatelessWidget {
  Person person;
  PersonsWidget({@required this.person});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          person.profileImage != null
              ? Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: style.Themes.secoundColor,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w200/${person.profileImage}",
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
            person.name,
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
            "trending for ${person.Know}",
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
}
