import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Models/MovieResonse.dart';
import 'package:movies/Models/Person.dart';
import 'package:movies/Models/PersonResonse.dart';
import 'package:movies/Repository/MovieRepository.dart';

part 'persons_event.dart';
part 'persons_state.dart';

class PersonsBloc extends Bloc<PersonsEvent, PersonsState> {
  PersonsBloc() : super(PersonsInitial());
  MovieRepository repo=MovieRepository();
  List<Person> persons;
  @override
  Stream<PersonsState> mapEventToState(
    PersonsEvent event,
  ) async* {
    if(event is FetchPersons)
    {
      yield LoadingStatePersons();
      try{
        PersonResonse response =await repo.getPersons();

        if(response!=null) {
          print("PERSONS${response.persons[0].name}");
          yield LoadedStatePersons(persons: response.persons);
        }
        else
          yield ErrorStatePersons(error: "NO data  Found");
      }on SocketException {
        yield ErrorStatePersons(error: 'No Internet',);
      } on HttpException {
        yield ErrorStatePersons(error: 'No Service Found',);
      } on FormatException {
        yield ErrorStatePersons(error: 'Invalid Response format',);
      } catch (e) {
        yield ErrorStatePersons(error: 'Unknown Error',);
      }
    }  }
}
