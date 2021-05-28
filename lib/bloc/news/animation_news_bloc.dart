import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/api_anime_news_item.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'animation_news_event.dart';

part 'animation_news_state.dart';

class AnimationNewsBloc extends Bloc<AnimationNewsEvent, AnimationNewsState> {

  final ApiRepository repository;

  AnimationNewsBloc({this.repository})
      : super(const AnimationNewsState(
            status: AnimationNewsStatus.Initial, newsItems: []));

  @override
  Stream<AnimationNewsState> mapEventToState(
    AnimationNewsEvent event,
  ) async* {
    if (event is AnimationNewsLoad) {
      yield* _mapToAnimationNewsLoad(event, state);
    }else if(event is AnimationNewsScrollToTop){
      yield* _mapToAnimationNewsScrollToTop();
    }
  }

  Stream<AnimationNewsState> _mapToAnimationNewsScrollToTop() async*{
    yield AnimationNewsState(status: AnimationNewsStatus.Loading , newsItems: state.newsItems);
    yield AnimationNewsState(status: AnimationNewsStatus.Scroll , currentPage: state.currentPage, newsItems: state.newsItems);
  }

  Stream<AnimationNewsState> _mapToAnimationNewsLoad(AnimationNewsLoad event, AnimationNewsState state) async*{
    yield AnimationNewsState(status: AnimationNewsStatus.Loading , newsItems: state.newsItems);
    await Future.delayed(const Duration(milliseconds: 500));
    String page = event.page ?? "1";
    const String viewCount = "30";
    ApiAnimeNewsItem result = await repository.getAnimationNewsItem(page, viewCount);
    if(result.err){
      yield AnimationNewsState(status: AnimationNewsStatus.Failure , msg: result.msg);
    }else{
      List<AnimationNewsItem> newsItems = result.data.map((newsItem) => AnimationNewsItem(title: newsItem.title, url: newsItem.url, imageUrl: newsItem.image ,date: newsItem.date, summary: newsItem.summary)).toList() ?? [];
      if(page != "1"){
        newsItems = state.newsItems..addAll(newsItems);
      }
      yield AnimationNewsState(status: AnimationNewsStatus.Success , newsItems: newsItems, currentPage: int.parse(page));
    }
  }
}
