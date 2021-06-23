part of 'person_bloc.dart';

class PersonState  extends Equatable{

  final BaseBlocStateStatus status;
  final AnimationPersonItem personItem;
  final String msg;

  const PersonState({this.status = BaseBlocStateStatus.Initial, this.personItem = AnimationPersonItem.empty, this.msg =""});

  PersonState copyWith({
    BaseBlocStateStatus status,
    AnimationPersonItem personItem,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (personItem == null || identical(personItem, this.personItem)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return PersonState(
      status: status ?? this.status,
      personItem: personItem ?? this.personItem,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object> get props =>[status, personItem , msg];
}
