import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/Models/CastResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'casts_event.dart';
part 'casts_state.dart';

class CastsBloc extends Bloc<CastsEvent, CastsState> {
  CastsBloc() : super(CastsInitial());
  MovieRepository repo=MovieRepository();
  @override
  Stream<CastsState> mapEventToState(CastsEvent event,) async* {
    if(event is FetchCastsDetails)
    {
      yield LoadingStateCasts();
      try{
        CastResponse response =await repo.getCasts(id:event.movieId);
        if(response!=null) {
          yield LoadedStateCasts(casts: response);
        }
        else yield ErrorStateCasts(error: "NO data  Found");
      }on SocketException {
        yield ErrorStateCasts(error: 'No Internet',);
      } on HttpException {
        yield ErrorStateCasts(error: 'No Service Found',);
      } on FormatException {
        yield ErrorStateCasts(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorStateCasts(error: 'Unknown Error',);
      }
    }
  }
}
