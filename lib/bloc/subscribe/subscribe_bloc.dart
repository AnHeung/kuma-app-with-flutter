import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/enums/base_bloc_state_status.dart';
import 'package:kuma_flutter_app/model/item/subscribe_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:meta/meta.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  final ApiRepository repository;

  SubscribeBloc({this.repository}) : super(const SubscribeState());

  @override
  Stream<SubscribeState> mapEventToState(
    SubscribeEvent event,
  ) async* {
    if (event is CheckSubscribe) {
      yield* _mapToCheckSubscribe(event);
    } else if (event is SubscribeUpdate) {
      yield* _mapToSubscribeUpdate(event);
    }
  }

  Stream<SubscribeState> _mapToCheckSubscribe(CheckSubscribe event) async* {
    try {
      User user = await repository.user;
      if (user.isNullOrEmpty) {
        yield const SubscribeState(status: BaseBlocStateStatus.Success,
            isLogin: false,
            isSubscribe: false);
      } else {
        String animationId = event.animationId;
        String userId = user.email;
        bool isSubscribe = await repository.isSubscribe(
            userId: userId, animationId: animationId);
        yield SubscribeState(
            status: BaseBlocStateStatus.Success,
            isLogin: true,
            isSubscribe: isSubscribe);
      }
    }catch(e){
      print("_mapToCheckSubscribe : $e");
      yield state.copyWith(status: BaseBlocStateStatus.Failure, msg: kSubscribeCheckErrMsg);
    }
  }

  Stream<SubscribeState> _mapToSubscribeUpdate(SubscribeUpdate event) async* {
    try {
      User user = await repository.user;
      if (user.isNullOrEmpty) {
            yield const SubscribeState(status: BaseBlocStateStatus.Success, isLogin: false, isSubscribe: false);
          } else {
            SubscribeItem item = event.item;
            String userId = user.email;
            bool isSubscribe = event.isSubScribe;
            bool result = await repository.updateSubscribeAnimation(userId: userId, item:item , isSubscribe: isSubscribe);
            yield SubscribeState(status: BaseBlocStateStatus.Success, isLogin: true, isSubscribe: result);
          }
    } catch (e) {
      print("_mapToSubscribeUpdate error :$e");
      yield state.copyWith(status: BaseBlocStateStatus.Failure,  msg: kSubscribeUpdateErrMsg);
    }
  }
}
