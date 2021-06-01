import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/api_anime_news_item.dart';
import 'package:kuma_flutter_app/model/item/animation_news_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:meta/meta.dart';

part 'animation_news_event.dart';
part 'animation_news_state.dart';

class AnimationNewsBloc extends Bloc<AnimationNewsEvent, AnimationNewsState> {
  final ApiRepository repository;

  AnimationNewsBloc({this.repository})
      : super(const AnimationNewsState(
            status: AnimationNewsStatus.Initial, newsItems: [] , newsQueryItems: []));

  @override
  Stream<AnimationNewsState> mapEventToState(
    AnimationNewsEvent event,
  ) async* {
    if (event is AnimationNewsLoad) {
      yield* _mapToAnimationNewsLoad(event);
    } else if (event is AnimationNewsScrollToTop) {
      yield* _mapToAnimationNewsScrollToTop();
    } else if (event is AnimationNewsSearch) {
      yield* _mapToAnimationNewsSearch(event);
    } else if (event is AnimationNewsClear) {
      yield* _mapToAnimationNewsClear();
    }
  }

  Stream<AnimationNewsState> _mapToAnimationNewsClear() async* {
    yield AnimationNewsState(
        status: AnimationNewsStatus.Success,
        currentPage: state.currentPage,
        newsItems: state.newsItems,
        newsQueryItems: state.newsItems);
  }

  Stream<AnimationNewsState> _mapToAnimationNewsSearch(
      AnimationNewsSearch event) async* {
    String query = event.query;
    if (query.isNullEmptyOrWhitespace) {
      yield AnimationNewsState(
          status: AnimationNewsStatus.Success,
          currentPage: state.currentPage,
          newsItems: state.newsItems,
          newsQueryItems: state.newsItems);
    } else {
      yield AnimationNewsState(
          status: AnimationNewsStatus.Success,
          currentPage: state.currentPage,
          newsItems: state.newsItems,
          newsQueryItems:  state.newsItems
              .where((item) =>
              item.title.toLowerCase().contains(query.toLowerCase()))
              .toList());
    }
  }

  Stream<AnimationNewsState> _mapToAnimationNewsScrollToTop() async* {
    yield AnimationNewsState(
        status: AnimationNewsStatus.Loading,
        newsItems: state.newsItems,
        newsQueryItems: state.newsQueryItems);
    yield AnimationNewsState(
        status: AnimationNewsStatus.Scroll,
        currentPage: state.currentPage,
        newsItems: state.newsItems,
        newsQueryItems: state.newsQueryItems);
  }

  Stream<AnimationNewsState> _mapToAnimationNewsLoad(
      AnimationNewsLoad event) async* {
    String page = event.page ?? "1";
    String query = event.query ?? "";
    const String viewCount = "30";
    yield AnimationNewsState(
        status: AnimationNewsStatus.Loading,
        newsItems: state.newsItems,
        newsQueryItems: state.newsQueryItems);
    await Future.delayed(const Duration(milliseconds: 500));

    ApiAnimeNewsItem result = await repository.getAnimationNewsItem(page, viewCount);

    if (result.err) {
      yield AnimationNewsState(
          status: AnimationNewsStatus.Failure,
          msg: result.msg,
          newsItems: state.newsItems,
          newsQueryItems: state.newsQueryItems,
          );
    } else {
      List<AnimationNewsItem> newsItems = result.data
              .map((newsItem) => AnimationNewsItem(
                  title: newsItem.title,
                  url: newsItem.url,
                  imageUrl: newsItem.image,
                  date: newsItem.date,
                  summary: newsItem.summary))
              .toList() ??
          [];
      if (page != "1") {
        newsItems = state.newsItems..addAll(newsItems);
      } else {
        page = "1";
      }
      yield AnimationNewsState(
        status: AnimationNewsStatus.Success,
        newsItems: newsItems,
        newsQueryItems: newsItems,
        currentPage: int.parse(page),
      );
      if(!query.isNullEmptyOrWhitespace) {
        add(AnimationNewsSearch(query: query));
      }
    }
  }
}
