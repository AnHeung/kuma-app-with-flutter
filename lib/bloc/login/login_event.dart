part of 'login_bloc.dart';

enum SocialType{ KAKAO ,GOOGLE , EMAIL,  UNKNOWN}

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

