part of 'subscribe_bloc.dart';

enum SubscribeStatus {Initial , Loading, Success , Failure}

@immutable
class SubscribeState {

  final SubscribeStatus status;
  final bool isLogin;
  final bool isSubscribe;
  final String msg;

  const SubscribeState({this.status, this.isLogin = false, this.isSubscribe = false , this.msg = "구독에러"});

}

