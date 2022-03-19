import 'package:hive/hive.dart';
import 'package:movies/Date/Models/Movie.dart';
class HiveOperations{
  static final _instance = HiveOperations._internal();
  HiveOperations._internal();
  static HiveOperations getInstance() {
    return _instance;
  }

  void insertIntoHive(List<Movie> moviesList) {
    final moviesBox = Hive.lazyBox('Movies');
    for (int i = 0; i < moviesList.length; i++) {
      moviesBox.add(moviesList[i]);
    }
  }
void removeData(){
  final moviesBox = Hive.lazyBox('Movies');
  moviesBox.clear();
}
  Future<List<Movie>> readSavedMovies()async{
    List<Movie> moviesList=[];
    final MoviesBox = Hive.lazyBox('Movies');
    for (int i = 0; i < MoviesBox.length; i++) {
      Movie movie =await  MoviesBox.get(i) as Movie;
      moviesList.add(movie);
    }
    return moviesList;
  }

}