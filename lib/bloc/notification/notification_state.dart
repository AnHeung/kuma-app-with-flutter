part of 'notification_bloc.dart';


enum NotificationStatus { Initial , Loading, Failure , Success }

@immutable
class NotificationState extends Equatable{

  final NotificationStatus status;
  final List<NotificationItem> notificationItems;
  final String msg;

  const NotificationState({this.status ,this.notificationItems ,this.msg});

  @override
  List<Object> get props => [status , notificationItems, msg];

}

