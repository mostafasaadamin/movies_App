part of 'persons_bloc.dart';

abstract class PersonsEvent extends Equatable {
  const PersonsEvent();

  @override
  List<Object> get props =>[];
}
class FetchPersons extends PersonsEvent {}