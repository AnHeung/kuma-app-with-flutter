part of 'character_bloc.dart';

enum CharacterStatus { loading, initial ,failure,  success }

class CharacterState extends Equatable{

  final CharacterStatus status;
  final List<AnimationCharacterItem> characterItems;
  final String msg;

  CharacterState({this.status = CharacterStatus.initial, this.characterItems, this.msg});

  @override
  List<Object> get props => [status, characterItems , msg];

}

