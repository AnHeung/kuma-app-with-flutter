part of 'subscribe_bloc.dart';

class SubscribeState extends Equatable{

  final BaseBlocStateStatus status;
  final bool isLogin;
  final bool isSubscribe;
  final String msg;

  const SubscribeState({this.status = BaseBlocStateStatus.Initial, this.isLogin = false, this.isSubscribe = false , this.msg = ""});

  @override
  List<Object> get props => [status, isLogin,  isSubscribe , msg];

  SubscribeState copyWith({
    BaseBlocStateStatus status,
    bool isLogin,
    bool isSubscribe,
    String msg,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (isLogin == null || identical(isLogin, this.isLogin)) &&
        (isSubscribe == null || identical(isSubscribe, this.isSubscribe)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return SubscribeState(
      status: status ?? this.status,
      isLogin: isLogin ?? this.isLogin,
      isSubscribe: isSubscribe ?? this.isSubscribe,
      msg: msg ?? this.msg,
    );
  }
}

