

enum LoginStatus {Initial , NeedRegister , CheckEmail , LoginSuccess, WrongPassword, Failure , Loading}


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
      default:
        return "로그인 실패";
    }
  }
}