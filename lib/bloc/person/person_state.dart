part of 'person_bloc.dart';

enum PersonStateStatus { initial ,loading, failure,  success}

class PersonState  extends Equatable{

  final PersonStateStatus status;
  final List<AnimationPersonItem> personItems;
  final String msg;


  PersonState({this.status, this.personItems, this.msg});

  @override
  List<Object> get props =>[status, personItems , msg];
}
