import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuma_flutter_app/model/api/api_notification_item.dart';
import 'package:kuma_flutter_app/model/api/api_simple_item.dart';
import 'package:kuma_flutter_app/model/item/notification_item.dart';
import 'package:kuma_flutter_app/repository/api_repository.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final ApiRepository repository;

  NotificationBloc({this.repository}) : super(const NotificationState(status: NotificationStatus.Initial, notificationItems: [] ));

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

  Stream<NotificationState> _mapToNotificationIsReadUpdate(NotificationIsReadUpdate event) async*{
    try {
      yield NotificationState(status: NotificationStatus.Loading , notificationItems: state.notificationItems,);
      String itemId = event.id;
      ApiSimpleItem apiSimpleItem =  await repository.updateIsRead(params:{"id":itemId});
      if(apiSimpleItem.err){
            yield NotificationState(status: NotificationStatus.Failure , notificationItems: state.notificationItems, msg: apiSimpleItem.msg);
          }else{
            yield NotificationState(status: NotificationStatus.Success , notificationItems: state.notificationItems);
            yield* _mapToNotificationLoad();
          }
    } catch (e) {
      print("_mapToNotificationIsReadUpdate error ${e}");
      yield NotificationState(status: NotificationStatus.NetworkError , notificationItems: state.notificationItems, msg: "통신에러 ${e}");
    }
  }

  Stream<NotificationState> _mapToNotificationLoad() async*{
    try {
      yield NotificationState(status: NotificationStatus.Loading , notificationItems: state.notificationItems,);
      String userId = await getUserId();
      ApiNotificationItem apiNotificationItem =  await repository.getNotificationItems(userId: userId);
      if(apiNotificationItem.err){
            yield NotificationState(status: NotificationStatus.Failure , notificationItems: [], msg: apiNotificationItem.msg);
          }else{
            yield NotificationState(status: NotificationStatus.Success , notificationItems: apiNotificationItem.data
                .map((pushItem) => NotificationItem(id:pushItem.id, userId: pushItem.userId, title: pushItem.title
                ,image: pushItem.image ,summary: pushItem.summary , date: pushItem.date ,mainTitle: pushItem.mainTitle
                ,thumbnail: pushItem.thumbnail, url: pushItem.url , isRead: pushItem.isRead)).toList(),
                msg: apiNotificationItem.msg);
          }
    } catch (e) {
      print("_mapToNotificationLoad error ${e}");
      yield NotificationState(status: NotificationStatus.NetworkError , notificationItems: [], msg: "통신에러 ${e}");
    }
  }
}
