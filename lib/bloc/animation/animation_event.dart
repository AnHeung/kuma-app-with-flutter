part of 'animation_bloc.dart';

@immutable
abstract class AnimationEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class AnimationLoad extends AnimationEvent{

  String rankType;
  String limit;
  String searchType;

  AnimationLoad({this.rankType, this.limit, this.searchType});

  @override
  List<Object> get props =>[rankType, limit,searchType];
}

class AnimationUpdate extends AnimationEvent{

  List<AnimationMainItem> rankingList;

  AnimationUpdate({this.rankingList});

  @override
  List<Object> get props =>[rankingList];
}



