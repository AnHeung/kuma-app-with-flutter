part of 'animation_character_bloc.dart';

enum AnimationCharacterStatus {initial , loading, failure , success}

class AnimationCharacterState extends Equatable{

  final AnimationCharacterStatus status;
  final List<AnimationCharacterItem> characterItems;
  final String msg;

  const  AnimationCharacterState({this.status , this.characterItems, this.msg});

  @override
  List<Object> get props => [status];

}

