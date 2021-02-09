part of 'animation_bloc.dart';

@immutable
abstract class AnimationState extends Equatable{

  @override
  List<Object> get props => [];
}

class AnimationLoadInProgress extends AnimationState{}

class AnimationLoadInFailure extends AnimationState{

  String errMsg;

  AnimationLoadInFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

class AnimationLoadSuccess extends AnimationState{

  List<AnimationMainItem> rankingList;

  AnimationLoadSuccess({this.rankingList});

  @override
  List<Object> get props =>[rankingList];
}