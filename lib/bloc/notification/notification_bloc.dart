import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';
import 'package:kuma_flutter_app/util/object_util.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final ApiRepository repository;

   NotificationBloc({this.repository}) : super(const NotificationState(status: NotificationStatus.Initial));

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if(event is NotificationLoad){
      yield* _mapToNotificationLoad(event);
    }else if(event is NotificationUpdate){
      yield* _mapToNotificationUpdate(event);
    }
  }

  Stream<NotificationState> _mapToNotificationLoad(NotificationLoad event) async*{

    User user = await repository.user;
    if(user.isNullOrEmpty) {
      yield const NotificationState(status: NotificationStatus.Success, isLogin: false,);
    } else {
      yield const NotificationState(status: NotificationStatus.Success, isLogin: true, );
    }
  }

  Stream<NotificationState> _mapToNotificationUpdate(NotificationUpdate event) async*{

  }
}
