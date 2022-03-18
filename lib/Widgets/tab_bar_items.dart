import 'package:flutter/material.dart';
import 'package:movies/Models/Genre.dart';
import 'package:movies/Style/theme.dart' as style;
import 'package:movies/Widgets/movie_by_genre.dart';

class TabBarItems extends StatefulWidget {
  List<Genre> genreList;

  TabBarItems({@required this.genreList});
  @override
  _TabBarItemsState createState() => _TabBarItemsState();
}

class _TabBarItemsState extends State<TabBarItems>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: widget.genreList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("data${widget.genreList.length}");
    return Container(
      height: 300.0,
      child: DefaultTabController(
          length: widget.genreList.length,
          child: Scaffold(
            backgroundColor: style.Themes.mainColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: style.Themes.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorWeight: 2.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                 indicatorColor: style.Themes.secoundColor,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: widget.genreList.map((Genre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Text(
                          genre.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ));
                  }).toList(),
                ),
              ),

            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: widget.genreList.map((Genre genre)
              {

                return MovieByGenre(genreId: genre.id);
              }).toList(),
            ),
          )),
    );
  }
}
