import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuma_flutter_app/model/api/notification_user.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/object_util.dart';
import 'package:meta/meta.dart';

part 'subscribe_event.dart';

part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  final ApiRepository repository;

  SubscribeBloc({this.repository})
      : super(const SubscribeState(status: SubscribeStatus.Initial));

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
    User user = await repository.user;
    if (user.isNullOrEmpty) {
      yield const SubscribeState(
          status: SubscribeStatus.Success, isLogin: false, isSubscribe: false);
    } else {
      String animationId = event.animationId;
      String userId = user.email;
      bool isSubscribe = await repository.isSubscribe(
          userId: userId, animationId: animationId);
      yield SubscribeState(
          status: SubscribeStatus.Success,
          isLogin: true,
          isSubscribe: isSubscribe);
    }
  }

  Stream<SubscribeState> _mapToSubscribeUpdate(SubscribeUpdate event) async* {
    try {
      User user = await repository.user;
      if (user.isNullOrEmpty) {
            yield const SubscribeState(
                status: SubscribeStatus.Success, isLogin: false, isSubscribe: false);
          } else {
            String animationId = event.animationId;
            String userId = user.email;
            bool isSubscribe = event.isSubScribe;
            bool result = await repository.updateSubscribeAnimation(userId: userId, animationId: animationId, isSubscribe: isSubscribe);
            yield SubscribeState(status: SubscribeStatus.Success, isLogin: true, isSubscribe: result);
          }
    } catch (e) {
      print("_mapToSubscribeUpdate error :$e");
      yield  SubscribeState(status: SubscribeStatus.Failure, isLogin: true, isSubscribe: false, msg: "구독에러 :$e");
    }
  }
}
