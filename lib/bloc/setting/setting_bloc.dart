import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {

  final ApiRepository repository;


  SettingBloc({this.repository}) : super(SettingLoadingInProgress());

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if(event is SettingLoad){
      yield* _mapToSettingLoad();
    }else if(event is ChangeSetting){
      yield* _mapToSettingChange(event);
    }else if(event is SettingScreenExit){
      yield SettingChangeComplete();
    }
  }

  Stream<SettingState> _mapToSettingLoad() async*{
    yield SettingLoadingInProgress();
    SettingConfig config = await getSettingConfig() ?? SettingConfig.empty;
    yield SettingLoadSuccess(config: config);
  }

  Stream<SettingState> _mapToSettingChange(ChangeSetting event) async*{
    await changeSettingConfig(config: event.config);
    yield SettingChange();
    yield SettingLoadSuccess(config: event.config);
  }
}
