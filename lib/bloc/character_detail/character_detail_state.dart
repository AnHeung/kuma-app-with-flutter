part of 'character_detail_bloc.dart';

enum CharacterDetailStatus { loading, initial ,failure,  success }

class CharacterState extends Equatable{

  final CharacterDetailStatus status;
  final AnimationCharacterDetailItem characterItem;
  final String msg;

  CharacterState({this.status = CharacterDetailStatus.initial, this.characterItem = AnimationCharacterDetailItem.empty, this.msg});

  @override
  List<Object> get props => [status, characterItem , msg];

}

