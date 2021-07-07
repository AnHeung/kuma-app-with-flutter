import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/api_notification_item.dart';
import 'package:kuma_flutter_app/model/api/api_simple_item.dart';
import 'package:kuma_flutter_app/model/item/notification_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/common.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final ApiRepository repository;
  final LoginBloc loginBloc;
  StreamSubscription subscription;

  NotificationBloc({this.repository , this.loginBloc}) : super(const NotificationState()){
    subscription = loginBloc.listen((state){
      print('tetstsat $state');
      if(state.status == LoginStatus.LoginSuccess){
        add(NotificationLoad());
      }
    });
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if(event is NotificationLoad){
      yield* _mapToNotificationLoad();
    }else if(event is NotificationIsReadUpdate){
      yield* _mapToNotificationIsReadUpdate(event);
    }
  }


  @override
  Future<Function> close() {
    subscription?.cancel();
    return super.close();
  }

  Stream<NotificationState> _mapToNotificationIsReadUpdate(NotificationIsReadUpdate event) async*{
    try {
      yield state.copyWith(status: NotificationStatus.Loading);
      String itemId = event.id;
      ApiSimpleItem apiSimpleItem =  await repository.updateIsRead(params:{"id":itemId});
      if(apiSimpleItem.err){
            yield state.copyWith(status: NotificationStatus.Failure ,  msg: apiSimpleItem.msg);
          }else{
           yield state.copyWith(status: NotificationStatus.Success);
           yield* _mapToNotificationLoad();
          }
    } catch (e) {
      print("_mapToNotificationIsReadUpdate error ${e}");
      yield state.copyWith(status: NotificationStatus.NetworkError ,msg: "통신에러 ${e}");
    }
  }

  Stream<NotificationState> _mapToNotificationLoad() async*{
    try {
      yield state.copyWith(status: NotificationStatus.Loading);
      String userId = await getUserId();
      ApiNotificationItem apiNotificationItem =  await repository.getNotificationItems(userId: userId);
      if(apiNotificationItem.err || apiNotificationItem.data == null){
            yield state.copyWith(status: NotificationStatus.Failure);
          }else{
              yield NotificationState(status: NotificationStatus.Success , notificationItems: apiNotificationItem.data.result
                  .map((pushItem) => NotificationItem(id:pushItem.id, userId: pushItem.userId, title: pushItem.title
                  ,image: pushItem.image ,summary: pushItem.summary , date: pushItem.date ,mainTitle: pushItem.mainTitle
                  ,thumbnail: pushItem.thumbnail, url: pushItem.url , isRead: pushItem.isRead)).toList(),
                  msg: apiNotificationItem.msg, unReadCount:apiNotificationItem.data.unReadCount);
          }
    } catch (e) {
      print("_mapToNotificationLoad error ${e}");
      yield state.copyWith(status: NotificationStatus.NetworkError , msg: "통신에러 ${e}");
    }
  }
}
