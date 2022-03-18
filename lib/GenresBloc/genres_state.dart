part of 'genres_bloc.dart';

abstract class GenresState extends Equatable {
  const GenresState();
  @override
  List<Object> get props => [];
}

class GenresInitial extends GenresState {}
class LoadingState extends GenresState {}
class LoadedStateGenres extends GenresState
{
  final List<Genre> genresList;
  LoadedStateGenres({@required this.genresList});
}
class ErrorStateGenres extends GenresState
{
  final  String error;
  ErrorStateGenres({@ required this.error});
}