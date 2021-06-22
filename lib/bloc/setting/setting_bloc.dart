import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {

  final ApiRepository repository;

  SettingBloc({this.repository}) : super(const SettingState().initialConfigState());

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if(event is SettingLoad){
      yield* _mapToSettingLoad();
    }else if(event is ChangeSetting){
      yield* _mapToSettingChange(event);
    }else if(event is SettingScreenExit){
      yield state.copyWith(status: SettingStatus.Complete);
    }
  }

  Stream<SettingState> _mapToSettingLoad() async*{
    try {
      yield SettingState(status: SettingStatus.Loading,config:state.config);
      LoginUserData userData = await getUserData();
      yield SettingState(status: SettingStatus.Success, config: SettingConfig(isAutoScroll: userData.isAutoScroll, receiveNotify: userData.receiveNotify,rankType: userData.rankType, homeItemCount: userData.homeItemCount));
    } catch (e) {
      print("_mapToSettingLoad error: ${e}");
      yield const SettingState(status:SettingStatus.Failure ,msg: "설정오류 다시 시도해주세요");
    }
  }

  Stream<SettingState> _mapToSettingChange(ChangeSetting event) async*{
    try {
      yield SettingState(status: SettingStatus.Loading, config: event.config);
      String userId  = await getUserId();
      if(userId == null) yield const SettingState(status:SettingStatus.Failure ,msg: "유저아이디 정보가 없습니다.");
      await repository.updateUserItemToFireStore(userId, event.config.toMap());
      await saveSettingConfig(settingConfig: event.config);
      yield SettingState(status:SettingStatus.Success,config: event.config);
    } catch (e) {
      print("_mapToSettingChange ${e}");
      yield SettingState(status: SettingStatus.Failure, msg: "ChangeSetting 실패 $e",config: event.config);
    }
  }
}
