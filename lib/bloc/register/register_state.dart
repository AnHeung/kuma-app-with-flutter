part of 'register_bloc.dart';

enum RegisterStatus {RegisterComplete , AlreadyInUse, RegisterFailure, Loading ,Initial}

extension RegisterStatusExtension on RegisterStatus{

  String get msg{

    switch (this) {
      case RegisterStatus.AlreadyInUse:
        return '이미 가입된 유저입니다. 다른 아이디로 로그인해주세요';
      case RegisterStatus.RegisterComplete:
        return '회원가입에 성공하였습니다.';
      default:
        return '회원가입 실패 재시도 요망';
    }
  }
}

class RegisterState  extends Equatable{

  final RegisterStatus status;

  RegisterState({this.status = RegisterStatus.Initial});

  @override
  List<Object> get props =>[status];
}

