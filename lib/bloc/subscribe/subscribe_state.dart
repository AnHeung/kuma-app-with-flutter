part of 'subscribe_bloc.dart';

enum SubscribeStatus {Initial , Loading, Success , Failure}

@immutable
class SubscribeState {

  final SubscribeStatus status;
  final bool isLogin;
  final bool isSubscribe;

  const SubscribeState({this.status, this.isLogin = false, this.isSubscribe = false});

}

