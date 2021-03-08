part of 'animation_season_bloc.dart';

@immutable
abstract class AnimationSeasonEvent extends Equatable{

  const AnimationSeasonEvent();

  @override
  List<Object> get props =>[];

}

class AnimationSeasonLoad extends AnimationSeasonEvent{

  final String limit;

  AnimationSeasonLoad({this.limit});

  @override
  List<Object> get props =>[limit];
}