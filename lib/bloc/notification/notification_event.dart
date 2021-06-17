part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable{


  @override
  List<Object> get props => [];

  const NotificationEvent();

}

class NotificationLoad extends NotificationEvent {}
