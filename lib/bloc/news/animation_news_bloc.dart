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
      yield* _mapToAnimationNewsLoad(event);
    }
  }

  Stream<AnimationNewsState> _mapToAnimationNewsLoad(AnimationNewsLoad event) async*{
    String page = event.page ?? "1";
    const String viewCount = "30";
    ApiAnimeNewsItem result = await repository.getAnimationNewsItem(page, viewCount);
    print("_mapToAnimationNewsLoad ${result}");
    if(result.err){
      yield AnimationNewsState(status: AnimationNewsStatus.Failure , msg: result.msg);
    }else{
      List<AnimationNewsItem> newsItems = result.data.map((newsItem) => AnimationNewsItem(title: newsItem.title, url: newsItem.url, imageUrl: newsItem.image ,date: newsItem.date, summary: newsItem.summary)).toList() ?? [];
      yield AnimationNewsState(status: AnimationNewsStatus.Success , newsItems: newsItems);
    }
  }
}
