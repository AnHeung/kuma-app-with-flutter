import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_season_item.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/model/item/animation_search_season_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:meta/meta.dart';

part 'animation_season_event.dart';
part 'animation_season_state.dart';

class AnimationSeasonBloc extends Bloc<AnimationSeasonEvent, AnimationSeasonState> {

  final ApiRepository repository;
  final SettingBloc settingBloc;

  AnimationSeasonBloc({this.repository,this.settingBloc}) : super(const AnimationSeasonState()) {
    settingBloc.listen((state) {
      if (state.status == SettingStatus.Complete) {
        add(AnimationSeasonLoad(limit: kSeasonLimitCount));
      }
    });
  }

  @override
  Stream<AnimationSeasonState> mapEventToState(
    AnimationSeasonEvent event,
  ) async* {
    if(event is AnimationSeasonLoad){
      yield* _mapToAnimationSeasonLoad(event);
    }
  }

  Stream<AnimationSeasonState> _mapToAnimationSeasonLoad(
      AnimationSeasonLoad event) async* {
    try {
      yield state.copyWith(status: AnimationSeasonStatus.Loading);
      String limit = event.limit;
      SearchMalApiSeasonItem items =  await repository.getSeasonItems(limit);
      bool isErr = items.err;
      if (isErr) {
            yield state.copyWith(status: AnimationSeasonStatus.Failure , msg: items.msg);
          } else {
            LoginUserData userData = await getUserData();
            bool isAutoScroll = userData.isAutoScroll ?? true;
            yield AnimationSeasonState(status:AnimationSeasonStatus.Success , seasonItems: List.from(
                items.result.map((data) =>
                    AnimationSeasonItem(
                        id: data.id, title: data.title, image: data.image))), isAutoScroll:isAutoScroll);
          }
    } catch (e) {
      print("_mapToAnimationSeasonLoad ${e}");
      yield state.copyWith(status: AnimationSeasonStatus.Failure , msg: "_mapToAnimationSeasonLoad ${e}");
    }
  }
}
