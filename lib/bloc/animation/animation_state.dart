part of 'animation_bloc.dart';

@immutable
abstract class AnimationState extends Equatable{

  @override
  List<Object> get props => [];
}

class AnimationLoadInProgress extends AnimationState{}

class AnimationLoadInit extends AnimationState{}

class AnimationLoadFailure extends AnimationState{

  final String errMsg;

  AnimationLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

class AnimationLoadSuccess extends AnimationState{

  final List<AnimationMainItem> rankingList;

  AnimationLoadSuccess({this.rankingList});

  @override
  List<Object> get props =>[rankingList];
}