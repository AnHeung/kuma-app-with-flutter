part of 'person_bloc.dart';

@immutable
abstract class PersonEvent extends Equatable {
  @override
  List<Object> get props => [];

  const PersonEvent();
}

class PersonLoad extends PersonEvent {

  final String personId;

  const PersonLoad({this.personId});
}
