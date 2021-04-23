part of 'login_bloc.dart';


@immutable
class LoginState extends Equatable{

   final LoginStatus status;
   final LoginUserData userData;
   final String msg;

   const LoginState({this.status = LoginStatus.Initial , this.userData = LoginUserData.empty , this.msg = ""});

  @override
  List<Object> get props =>[status,userData,msg];
}


