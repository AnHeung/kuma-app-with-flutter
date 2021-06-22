import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/enums/login_status.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_ranking_item.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
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
  final LoginBloc loginBloc;

  AnimationBloc({this.repository, this.settingBloc , this.loginBloc}) : super(AnimationLoadInit()){
    settingBloc.listen((state) {
      if(state.status == SettingStatus.Complete){
        add(AnimationLoad());
      }
    });
    loginBloc.listen((state) {
      if(state.status == LoginStatus.LoginSuccess){
        add(AnimationLoad());
      }
    });
  }

  @override
  Stream<AnimationState> mapEventToState(
    AnimationEvent event,
  ) async* {
    if (event is AnimationLoad) {
      yield* _mapToAnimationLoad();
    } else if (event is AnimationUpdate) {
      yield* _mapToAnimationLoadUpdate(event);
    }
  }

  Stream<AnimationState> _mapToAnimationLoad() async* {
    try {
      yield AnimationLoadInProgress();

      LoginUserData userData = await getUserData();
      String type = "anime";
      String page = "1";
      String rankType = userData.rankType ?? kBaseRankItem;
      String limit = userData.homeItemCount ?? kBaseHomeItemCount;
      SearchRankingApiResult searchRankingApiResult = await repository.getRankingItemList(type,page,rankType, limit);
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
                            ranking: data.ranking , score:data.score))
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
