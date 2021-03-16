part of 'login_bloc.dart';

enum SocialType{ KAKAO ,GOOGLE , EMAIL,  UNKNOWN}

extension SocialTypeExtension on SocialType{

  String get iconRes {

    switch(this){
      case SocialType.KAKAO:
        return "assets/images/kakao_talk_logo_color.png";
      case SocialType.GOOGLE:
        return "assets/images/google_icon.png";
      case SocialType.EMAIL:
        return "assets/images/kakao_talk_logo.png";
      case SocialType.UNKNOWN:
        return "assets/images/kakao_talk_logo.png";

    }

  }
}

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

