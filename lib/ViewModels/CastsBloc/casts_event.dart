import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
abstract class CastsEvent extends Equatable {
  const CastsEvent();
  @override
  List<Object> get props =>[];
}
class FetchCastsDetails extends CastsEvent
{
  int movieId;
  FetchCastsDetails({@required this.movieId});
}