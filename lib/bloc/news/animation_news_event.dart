part of 'animation_news_bloc.dart';

@immutable
abstract class AnimationNewsEvent extends Equatable{

  @override
  List<Object> get props => [];

  const AnimationNewsEvent();
}

class AnimationNewsLoad extends AnimationNewsEvent{

  final String page;
  final String startDate;
  final String endDate;

  AnimationNewsLoad({this.page = "1" ,startDate , endDate}): this.startDate =  startDate ??  getToday() ,this.endDate = endDate ?? getToday();

  @override
  List<Object> get props => [page,startDate ,endDate];
}

class AnimationNewsScrollToTop extends AnimationNewsEvent{}

class AnimationNewsChangeDate extends AnimationNewsEvent{
  final String startDate;
  final String endDate;

  const AnimationNewsChangeDate({this.startDate,this.endDate});

  @override
  List<Object> get props => [startDate,endDate];
}
