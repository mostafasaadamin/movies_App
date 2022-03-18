part of 'persons_bloc.dart';

abstract class PersonsState extends Equatable {
  const PersonsState();
  @override
  List<Object> get props => [];
}
class PersonsInitial extends PersonsState {}

class LoadingStatePersons extends PersonsState {}
class LoadedStatePersons extends PersonsState
{
  final List<Person> persons;
  LoadedStatePersons({@required this.persons});
}
class ErrorStatePersons extends PersonsState
{
  final  String error;
  ErrorStatePersons({@ required this.error});
}