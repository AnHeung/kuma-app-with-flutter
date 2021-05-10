part of 'animation_character_bloc.dart';

@immutable
abstract class AnimationCharacterEvent extends Equatable{

  @override
  List<Object> get props => [];

  const AnimationCharacterEvent();
}

class AnimationCharacterLoad extends  AnimationCharacterEvent{
  final String id;

  const AnimationCharacterLoad({this.id});
}
