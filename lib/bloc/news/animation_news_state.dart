part of 'animation_news_bloc.dart';

enum AnimationNewsStatus {Initial , Loading, Success,Failure}

class AnimationNewsState extends Equatable{

  final AnimationNewsStatus status;
  final List<AnimationNewsItem> newsItems;
  final String msg;

  const AnimationNewsState({this.status, this.newsItems, this.msg});

  @override
  List<Object> get props => [status, newsItems , msg];
}

