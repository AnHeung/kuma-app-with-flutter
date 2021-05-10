part of 'character_detail_bloc.dart';

@immutable
abstract class CharacterDetailEvent extends Equatable{


  @override
  List<Object> get props =>[];

  const CharacterDetailEvent();

}

class CharacterDetailLoad extends CharacterDetailEvent{

  final String characterId;

  const CharacterDetailLoad({this.characterId});
}
