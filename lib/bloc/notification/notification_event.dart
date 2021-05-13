part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable{

  @override
  List<Object> get props =>[];

  const NotificationEvent();
}

class NotificationUpdate extends NotificationEvent{

  final bool isNotification;

  const NotificationUpdate({this.isNotification});

  @override
  List<Object> get props =>[isNotification];
}


class NotificationLoad extends NotificationEvent{

  final String animationId;

  const NotificationLoad({this.animationId});

  @override
  List<Object> get props =>[animationId];
}
