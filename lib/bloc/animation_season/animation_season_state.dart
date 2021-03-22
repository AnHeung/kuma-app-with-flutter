part of 'animation_season_bloc.dart';

@immutable
abstract class AnimationSeasonState extends Equatable{

  const AnimationSeasonState();

  @override
  List<Object> get props =>[];

}

class AnimationSeasonLoadInProgress extends AnimationSeasonState{}

class AnimationSeasonLoadFailure extends AnimationSeasonState{

  final String errMsg;

  AnimationSeasonLoadFailure({this.errMsg});

  @override
  List<Object> get props =>[errMsg];
}

class AnimationSeasonLoadSuccess extends AnimationSeasonState{

  final List<AnimationSeasonItem> seasonItems;
  final bool isAutoScroll;

  AnimationSeasonLoadSuccess({this.seasonItems, this.isAutoScroll});

  @override
  List<Object> get props =>[seasonItems,isAutoScroll];
}
