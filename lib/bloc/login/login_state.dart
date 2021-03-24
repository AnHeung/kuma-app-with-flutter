part of 'login_bloc.dart';


@immutable
class LoginState extends Equatable{

   final LoginStatus status;
   final LoginUserData userData;

   const LoginState._({this.status = LoginStatus.Initial , this.userData = LoginUserData.empty});
   const LoginState.needRegister({LoginUserData userData}):this._(status:LoginStatus.NeedRegister, userData:userData);
   const LoginState.loading():this._(status:LoginStatus.Loading);
   const LoginState.success():this._(status:LoginStatus.LoginSuccess);
   const LoginState.wrongPassword():this._(status:LoginStatus.WrongPassword);
   const LoginState.failure():this._(status:LoginStatus.Failure);
   const LoginState.checkEmail():this._(status:LoginStatus.CheckEmail);
   const LoginState.needLoginScreen():this._(status:LoginStatus.NeedLoginScreen);

  @override
  List<Object> get props =>[status];
}


