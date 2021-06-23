part of 'login_bloc.dart';

enum LoginType{ KAKAO ,GOOGLE , EMAIL,  UNKNOWN}

extension SocialTypeExtension on LoginType{
  String get iconRes {
    switch(this){
      case LoginType.KAKAO:
        return "assets/images/kakao_talk_logo_color.png";
      case LoginType.GOOGLE:
        return "assets/images/google_icon.png";
      case LoginType.EMAIL:
        return "assets/images/email_icon.png";
      case LoginType.UNKNOWN:
        return "assets/images/no_image.png";
      default:
        return "assets/images/no_image.png";
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

  final LoginType type;
  final BuildContext context;

  const Login({this.type, this.context});

  @override
  List<Object> get props => [type];
}


class DirectLogin extends LoginEvent {

  final LoginUserData userData;

  const DirectLogin({this.userData});

  @override
  List<Object> get props => [userData];
}