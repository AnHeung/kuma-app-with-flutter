import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'animation_event.dart';

part 'animation_state.dart';

class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  ApiRepository repository;

  AnimationBloc({this.repository}) : super(AnimationLoadInProgress());

  @override
  Stream<AnimationState> mapEventToState(
    AnimationEvent event,
  ) async* {
    if (event is AnimationLoad) {
      yield* _mapToAnimationLoad(event);
    } else if (event is AnimationUpdate) {
      yield* _mapToAnimationLoadUpdate(event);
    }
  }

  Stream<AnimationState> _mapToAnimationLoad(AnimationLoad event) async* {
    yield AnimationLoadInProgress();
    String rankType = event.rankType ?? "all";
    String searchType = event.searchType ?? "all";
    String limit = event.limit ?? "30";
    SearchRankingApiResult searchRankingApiResult = await repository.getRankingItemList(rankType, limit ,searchType);
    bool isErr  = searchRankingApiResult.err;
    if(isErr) yield AnimationLoadInFailure(errMsg: searchRankingApiResult.msg);
    else yield AnimationLoadSuccess(rankingList: searchRankingApiResult.result.map((result) => AnimationMainItem()).toList());
  }

  Stream<AnimationState> _mapToAnimationLoadUpdate(
      AnimationUpdate event) async* {
    yield AnimationLoadInProgress();
    List<AnimationMainItem> rankItem = event.rankingList;
    yield AnimationLoadSuccess(rankingList: rankItem);
  }
}
