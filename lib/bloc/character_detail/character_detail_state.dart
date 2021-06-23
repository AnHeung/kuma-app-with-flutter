part of 'character_detail_bloc.dart';

class CharacterState extends Equatable{

  final BaseBlocStateStatus status;
  final AnimationCharacterDetailItem characterItem;
  final String msg;

  const CharacterState({this.status = BaseBlocStateStatus.Initial, this.characterItem = AnimationCharacterDetailItem.empty, this.msg});

  CharacterState copyWith({
    BaseBlocStateStatus status,
    AnimationCharacterDetailItem characterItem,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (characterItem == null ||
            identical(characterItem, this.characterItem)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new CharacterState(
      status: status ?? this.status,
      characterItem: characterItem ?? this.characterItem,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object> get props => [status, characterItem , msg];

}

