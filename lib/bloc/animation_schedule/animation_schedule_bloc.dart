import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/bloc/setting/setting_bloc.dart';
import 'package:kuma_flutter_app/model/api/search_mal_api_schedule_item.dart';
import 'package:kuma_flutter_app/model/item/animation_schedule_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'animation_schedule_event.dart';
part 'animation_schedule_state.dart';

class AnimationScheduleBloc extends Bloc<AnimationScheduleEvent, AnimationScheduleState> {

  final ApiRepository repository;
  final SettingBloc settingBloc;

  AnimationScheduleBloc({this.repository,this.settingBloc}) : super(AnimationScheduleLoadInProgress(currentDay: "1"));

  @override
  Stream<AnimationScheduleState> mapEventToState(
    AnimationScheduleEvent event,
  ) async* {
    try {
      if (event is AnimationScheduleInitLoad) {
        yield* _mapToScheduleInitLoad();
      } else if (event is AnimationScheduleLoad) {
        yield* _mapToScheduleLoad(event);
      }
    }catch(e){
      yield AnimationScheduleLoadFailure(errMsg:"error : $e");
    }
  }

  Stream<AnimationScheduleState> _mapToScheduleInitLoad() async*{
    await Future.delayed(Duration(seconds: 1));
    add(AnimationScheduleLoad(day: "1"));
  }

  Stream<AnimationScheduleState> _mapToScheduleLoad(AnimationScheduleLoad event) async*{
    yield AnimationScheduleLoadInProgress(currentDay: event.day);
    SearchMalApiScheduleItem scheduleItem = await repository.getScheduleItems(event.day);
    print('_mapToScheduleLoad ${event.day} scheduleItem :$scheduleItem');
    if(scheduleItem.err){
      yield AnimationScheduleLoadFailure(errMsg: scheduleItem.msg);
    }else{
      if(scheduleItem.result != null && scheduleItem.result.length > 0)
      yield AnimationScheduleLoadSuccess(currentDay: event.day ,
          scheduleItems: scheduleItem.result.map((schedule) => AnimationScheduleItem(title: schedule.title
              , id: schedule.id
              ,image: schedule.image
              ,startDate: schedule.startDate
              , score: schedule.score.toString())).toList());
    }
  }
}
