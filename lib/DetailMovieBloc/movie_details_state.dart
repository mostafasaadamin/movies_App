part of 'movie_details_bloc.dart';
abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object> get props => [];
}
class MovieDetailsInitial extends MovieDetailsState {

}
class LoadingState extends MovieDetailsState {}
class LoadedState extends MovieDetailsState {
  final MovieDetails movie;
  LoadedState({@required this.movie});
}
class ErrorState extends MovieDetailsState {
  final  String error;
  ErrorState({@ required this.error});
}