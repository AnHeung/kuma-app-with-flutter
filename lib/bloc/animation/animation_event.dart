part of 'animation_bloc.dart';

@immutable
abstract class AnimationEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class AnimationLoad extends AnimationEvent{}

class AnimationUpdate extends AnimationEvent{

  final List<AnimationMainItem> rankingList;

  AnimationUpdate({this.rankingList});

  @override
  List<Object> get props =>[rankingList];
}


