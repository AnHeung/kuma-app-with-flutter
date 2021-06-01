part of 'animation_news_bloc.dart';

@immutable
abstract class AnimationNewsEvent extends Equatable{

  @override
  List<Object> get props => [];

  const AnimationNewsEvent();
}

class AnimationNewsLoad extends AnimationNewsEvent{

  final String page;
  final String query;

  const AnimationNewsLoad({this.page = "1" ,this.query = ""});

  @override
  List<Object> get props => [page,query];
}

class AnimationNewsScrollToTop extends AnimationNewsEvent{}

class AnimationNewsClear extends AnimationNewsEvent{}

class AnimationNewsSearch extends AnimationNewsEvent{

  final String query;

  const AnimationNewsSearch({this.query});

  @override
  List<Object> get props => [query];
}