part of 'animation_news_bloc.dart';

enum AnimationNewsStatus {Initial , Loading, Success,Failure , Scroll}

class AnimationNewsState extends Equatable{

  final AnimationNewsStatus status;
  final List<AnimationNewsItem> newsItems;
  final int currentPage;
  final String startDate;
  final String endDate;
  final String msg;

  AnimationNewsState({this.status, this.newsItems, this.msg, this.currentPage = 1 ,String startDate, String endDate}): this.startDate =  startDate ??  getToday() ,this.endDate = endDate ?? getToday();

  @override
  List<Object> get props => [status, newsItems , msg,currentPage,startDate, endDate];
}

