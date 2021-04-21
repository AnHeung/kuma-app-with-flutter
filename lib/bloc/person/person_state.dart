part of 'person_bloc.dart';

enum PersonStateStatus { initial ,loading, failure,  success}

class PersonState  extends Equatable{

  final PersonStateStatus status;
  final AnimationPersonItem personItem;
  final String msg;


  PersonState({this.status, this.personItem = AnimationPersonItem.empty, this.msg});

  @override
  List<Object> get props =>[status, personItem , msg];
}
