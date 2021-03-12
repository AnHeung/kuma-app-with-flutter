part of 'auth_bloc.dart';

enum AuthStatus {
  UnAuth, Auth, UnKnown
}

extension AuthExtension on AuthStatus {
  String get msg {
    switch (this) {
      case AuthStatus.Auth:
        return '인증에 성공';
      case AuthStatus.UnAuth:
        return '인증 실패 재 인증 필요';
      case AuthStatus.UnKnown:
        return '인증상태를 알수 없음';
      default:
        return "인증오류";
    }
  }
}

@immutable
class AuthState extends Equatable {

  final AuthStatus status;

  const AuthState._({this.status = AuthStatus.UnKnown});

  const AuthState.auth() : this._(status:AuthStatus.Auth);

  const AuthState.unAuth(): this._(status:AuthStatus.UnAuth);

  const AuthState.unKnown(): this._(status:AuthStatus.UnKnown);


  @override
  List<Object> get props =>[status];

}

