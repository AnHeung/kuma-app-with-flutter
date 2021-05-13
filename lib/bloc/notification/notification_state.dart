part of 'notification_bloc.dart';

enum NotificationStatus {Initial , Loading, Success , Failure}

@immutable
class NotificationState {

  final NotificationStatus status;
  final bool isLogin;

  const NotificationState({this.status, this.isLogin = false});

}

