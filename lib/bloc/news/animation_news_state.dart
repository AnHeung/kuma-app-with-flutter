part of 'animation_news_bloc.dart';

enum AnimationNewsStatus {Initial , Loading, Success,Failure , Scroll}

class AnimationNewsState extends Equatable{

  final AnimationNewsStatus status;
  final List<AnimationNewsItem> newsItems;
  final List<AnimationNewsItem> newsQueryItems;
  final int currentPage;
  final String msg;

  const AnimationNewsState({this.status = AnimationNewsStatus.Initial, this.newsItems = const<AnimationNewsItem>[], this.newsQueryItems = const<AnimationNewsItem>[],this.msg = "", this.currentPage = 1  });

  AnimationNewsState copyWith({
    AnimationNewsStatus status,
    List<AnimationNewsItem> newsItems,
    List<AnimationNewsItem> newsQueryItems,
    int currentPage,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (newsItems == null || identical(newsItems, this.newsItems)) &&
        (newsQueryItems == null ||
            identical(newsQueryItems, this.newsQueryItems)) &&
        (currentPage == null || identical(currentPage, this.currentPage)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new AnimationNewsState(
      status: status ?? this.status,
      newsItems: newsItems ?? this.newsItems,
      newsQueryItems: newsQueryItems ?? this.newsQueryItems,
      currentPage: currentPage ?? this.currentPage,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object> get props => [status, newsItems , msg,currentPage, newsQueryItems];
}

