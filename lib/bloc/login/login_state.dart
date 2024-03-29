part of 'login_bloc.dart';

enum LoginStatus {Initial , NeedRegister , CheckEmail , LoginSuccess, NeedLoginScreen,  WrongPassword, Failure , Loading}

extension LoginStatusExtension on LoginStatus{

  String get msg{
    switch (this) {
      case LoginStatus.Initial:
        return '로그인 페이지';
      case LoginStatus.LoginSuccess:
        return '로그인 성공';
      case LoginStatus.WrongPassword:
        return '비밀번호가 틀렸습니다. 다시 시도해주세요';
      case LoginStatus.CheckEmail:
        return '이메일을 체크하지 않았습니다. 이메일 체크후 다시 시도해주세요';
      case LoginStatus.NeedRegister:
        return '회원가입 필요';
      case LoginStatus.Failure:
        return '로그인 실패';
      case LoginStatus.NeedLoginScreen:
        return "로그인 필요";
      default:
        return "로그인 실패";
    }
  }
}

class LoginState extends Equatable{

   final LoginStatus status;
   final LoginUserData userData;
   final String msg;

   const LoginState({this.status = LoginStatus.Initial , this.userData = LoginUserData.empty , this.msg = ""});

  @override
  List<Object> get props =>[status,userData,msg];
}


