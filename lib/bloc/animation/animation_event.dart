part of 'animation_bloc.dart';

@immutable
abstract class AnimationEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class AnimationLoad extends AnimationEvent{

  final String rankType;
  final String limit;
  final String searchType;

  AnimationLoad({this.rankType, this.limit, this.searchType});

  @override
  List<Object> get props =>[rankType, limit,searchType];
}

class AnimationSeasonLoad extends AnimationEvent{

  final String limit;

  AnimationSeasonLoad({this.limit});

  @override
  List<Object> get props =>[limit];
}

class AnimationUpdate extends AnimationEvent{

  final List<AnimationMainItem> rankingList;

  AnimationUpdate({this.rankingList});

  @override
  List<Object> get props =>[rankingList];
}


