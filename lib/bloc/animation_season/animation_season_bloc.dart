import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_season_item.dart';
import 'package:kuma_flutter_app/model/item/animation_search_season_item.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'animation_season_event.dart';
part 'animation_season_state.dart';

class AnimationSeasonBloc extends Bloc<AnimationSeasonEvent, AnimationSeasonState> {

  final ApiRepository repository;
  final SettingBloc settingBloc;

  AnimationSeasonBloc({this.repository,this.settingBloc}) : super(AnimationSeasonLoadInProgress()) {
    settingBloc.listen((state) {
      if (state is SettingChangeComplete) {
        add(AnimationSeasonLoad(limit: "7"));
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
    yield AnimationSeasonLoadInProgress();
    String limit = event.limit;
    SearchMalApiSeasonItem items =  await repository.getSeasonItems(limit);
    bool isErr = items.err;
    if (isErr) {
      yield AnimationSeasonLoadFailure(errMsg: items.msg);
    } else {
      SettingConfig config = await getSettingConfig();
      bool isAutoScroll = config.isAutoScroll;
      yield AnimationSeasonLoadSuccess(seasonItems: List.from(
          items.result.map((data) =>
              AnimationSeasonItem(
                  id: data.id, title: data.title, image: data.image))), isAutoScroll:isAutoScroll);
    }
  }
}
