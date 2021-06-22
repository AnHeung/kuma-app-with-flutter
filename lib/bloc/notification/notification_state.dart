part of 'notification_bloc.dart';


enum NotificationStatus { Initial , Loading, Failure , Success , NetworkError }

@immutable
class NotificationState extends Equatable{

  final NotificationStatus status;
  final List<NotificationItem> notificationItems;
  final String msg;
  final String unReadCount;

  const NotificationState({this.status ,this.notificationItems ,this.msg ,this.unReadCount = "0"});

  NotificationState initNotification(){
    return const NotificationState(status: NotificationStatus.Initial, notificationItems: [] ,unReadCount: "0" ,msg: "");
  }

  NotificationState copyWith({
    NotificationStatus status,
    List<NotificationItem> notificationItems,
    String msg,
    bool isAllRead,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (notificationItems == null ||
            identical(notificationItems, this.notificationItems)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isAllRead == null || identical(isAllRead, this.unReadCount))) {
      return this;
    }

    return NotificationState(
      status: status ?? this.status,
      notificationItems: notificationItems ?? this.notificationItems,
      msg: msg ?? this.msg,
      unReadCount: isAllRead ?? this.unReadCount,
    );
  }

  @override
  List<Object> get props => [status , notificationItems, msg, unReadCount];

}

