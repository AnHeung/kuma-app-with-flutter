part of 'login_bloc.dart';

enum SocialType{ KAKAO ,GOOGLE}

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];

  const LoginEvent();
}

class Login extends LoginEvent {

  final SocialType type;
  final BuildContext context;

  const Login({this.type, this.context});

  @override
  List<Object> get props => [type];
}

class Logout extends LoginEvent{

  final SocialType type;
  final BuildContext context;

  const Logout({this.type, this.context});

  @override
  List<Object> get props =>[type,context];
}

