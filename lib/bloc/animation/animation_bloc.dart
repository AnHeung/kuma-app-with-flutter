import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/item/animation_main_item.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'animation_event.dart';
part 'animation_state.dart';


class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {

  final ApiRepository repository;
  final SettingBloc settingBloc;

  AnimationBloc({this.repository, this.settingBloc}) : super(AnimationLoadInit()){
    settingBloc.listen((state) {
      if(state is SettingChangeComplete){
        add(AnimationLoad());
      }
    });
  }

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
    try {
      yield AnimationLoadInProgress();

      SettingConfig config = await getSettingConfig();

      String rankType = config.rankingType;
      String limit = config.aniLoadItemCount;
      SearchRankingApiResult searchRankingApiResult = await repository.getRankingItemList(rankType, limit);
      bool isErr = searchRankingApiResult.err;
      if (isErr)
        yield AnimationLoadFailure(errMsg: searchRankingApiResult.msg);
      else
        yield AnimationLoadSuccess(
            rankingList: searchRankingApiResult.result
                .map((result) =>
                AnimationMainItem(
                    koreaType: result.koreaType,
                    type: result.type,
                    list: result.rank_result
                        .map((data) =>
                        RankingItem(
                            id: data.id,
                            title: data.title,
                            image: data.image,
                            ranking: data.ranking))
                        .toList()))
                .toList());
    }on Exception{
      yield AnimationLoadFailure(errMsg: "통신 에러 발생");
    }
  }

  Stream<AnimationState> _mapToAnimationLoadUpdate(
      AnimationUpdate event) async* {
    yield AnimationLoadInProgress();
    List<AnimationMainItem> rankItem = event.rankingList;
    yield AnimationLoadSuccess(rankingList: rankItem);
  }
}
