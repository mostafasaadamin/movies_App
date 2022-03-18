part of 'casts_bloc.dart';

abstract class CastsState extends Equatable {
  const CastsState();
  @override
  List<Object> get props => [];
}
class CastsInitial extends CastsState {}
class LoadingStateCasts extends CastsState {}
class LoadedStateCasts extends CastsState {
  final CastResponse casts;
  LoadedStateCasts({@required this.casts});
}
class ErrorStateCasts extends CastsState {
  final  String error;
  ErrorStateCasts({@required this.error});
}