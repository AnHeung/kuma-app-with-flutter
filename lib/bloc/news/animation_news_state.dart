part of 'animation_news_bloc.dart';

enum AnimationNewsStatus {Initial , Loading, Success,Failure , Scroll}

class AnimationNewsState extends Equatable{

  final AnimationNewsStatus status;
  final List<AnimationNewsItem> newsItems;
  final List<AnimationNewsItem> newsQueryItems;
  final int currentPage;
  final String msg;

  const AnimationNewsState({this.status = AnimationNewsStatus.Initial, this.newsItems = const<AnimationNewsItem>[], this.newsQueryItems = const<AnimationNewsItem>[],this.msg = "", this.currentPage = 1  });

  @override
  List<Object> get props => [status, newsItems , msg,currentPage, newsQueryItems];
}

