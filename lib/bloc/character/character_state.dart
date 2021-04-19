part of 'character_bloc.dart';

enum CharacterStatus { loading, initial ,failure,  success }

class CharacterState extends Equatable{

  final CharacterStatus status;
  final AnimationCharacterItem characterItem;
  final String msg;

  CharacterState({this.status = CharacterStatus.initial, this.characterItem = AnimationCharacterItem.empty, this.msg});

  @override
  List<Object> get props => [status, characterItem , msg];

}

