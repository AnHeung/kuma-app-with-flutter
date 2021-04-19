part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent extends Equatable{


  @override
  List<Object> get props =>[];

  const CharacterEvent();

}

class CharacterLoad extends CharacterEvent{

  final String characterId;

  const CharacterLoad({this.characterId});
}
