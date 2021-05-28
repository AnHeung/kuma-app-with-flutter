part of 'animation_news_bloc.dart';

@immutable
abstract class AnimationNewsEvent extends Equatable{

  @override
  List<Object> get props => [];

  const AnimationNewsEvent();
}

class AnimationNewsLoad extends AnimationNewsEvent{

  final String page;

  const AnimationNewsLoad({this.page = "1"});

  @override
  List<Object> get props => [page];
}

class AnimationNewsScrollToTop extends AnimationNewsEvent{}
