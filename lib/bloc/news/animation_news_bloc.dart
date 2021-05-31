import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/api_anime_news_item.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/date_util.dart';
import 'package:meta/meta.dart';

part 'animation_news_event.dart';

part 'animation_news_state.dart';

class AnimationNewsBloc extends Bloc<AnimationNewsEvent, AnimationNewsState> {

  final ApiRepository repository;

  AnimationNewsBloc({this.repository}) : super(AnimationNewsState(status: AnimationNewsStatus.Initial, newsItems: []));

  @override
  Stream<AnimationNewsState> mapEventToState(
    AnimationNewsEvent event,
  ) async* {
    if (event is AnimationNewsLoad) {
      yield* _mapToAnimationNewsLoad(event, state);
    }else if(event is AnimationNewsScrollToTop){
      yield* _mapToAnimationNewsScrollToTop();
    }else if(event is AnimationNewsChangeDate){
      yield* _mapToAnimationNewsChangeDate(event ,state);
    }
  }

  Stream<AnimationNewsState> _mapToAnimationNewsScrollToTop() async*{
    yield AnimationNewsState(status: AnimationNewsStatus.Loading , newsItems: state.newsItems);
    yield AnimationNewsState(status: AnimationNewsStatus.Scroll , currentPage: state.currentPage, newsItems: state.newsItems);
  }

  Stream<AnimationNewsState> _mapToAnimationNewsChangeDate(AnimationNewsChangeDate event, AnimationNewsState state) async*{
    yield AnimationNewsState(status: AnimationNewsStatus.Loading , newsItems: state.newsItems);
    String startDate = event.startDate;
    String endDate = event.endDate;
    bool isBigger = compareTime(startDate ,endDate);
    if(isBigger) {
      startDate = endDate;
    }
    yield AnimationNewsState(status: AnimationNewsStatus.Success , currentPage: state.currentPage, newsItems: state.newsItems , startDate: startDate , endDate: endDate);
  }

  Stream<AnimationNewsState> _mapToAnimationNewsLoad(AnimationNewsLoad event, AnimationNewsState state) async*{
    String page = event.page ?? "1";
    String startDate = event.startDate ?? "1";
    String endDate = event.endDate ?? "1";
    const String viewCount = "30";
    yield AnimationNewsState(status: AnimationNewsStatus.Loading , newsItems: state.newsItems ,startDate: startDate ,endDate: endDate);
    await Future.delayed(const Duration(milliseconds: 500));
    ApiAnimeNewsItem result = await repository.getAnimationNewsItem(page, viewCount, startDate, endDate);
    if(result.err){
      yield AnimationNewsState(status: AnimationNewsStatus.Failure , msg: result.msg, newsItems: []);
    }else{
      List<AnimationNewsItem> newsItems = result.data.map((newsItem) => AnimationNewsItem(title: newsItem.title, url: newsItem.url, imageUrl: newsItem.image ,date: newsItem.date, summary: newsItem.summary)).toList() ?? [];
      if(page != "1"){
        newsItems = state.newsItems..addAll(newsItems);
      }
      yield AnimationNewsState(status: AnimationNewsStatus.Success , newsItems: newsItems, currentPage: int.parse(page), startDate: startDate , endDate: endDate);
    }
  }
}
