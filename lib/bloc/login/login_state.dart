part of 'login_bloc.dart';


@immutable
class LoginState extends Equatable{

   final LoginStatus status;
   final SocialUserData userData;

   const LoginState._({this.status = LoginStatus.Initial , this.userData = SocialUserData.empty});
   const LoginState.needRegister({SocialUserData userData}):this._(status:LoginStatus.NeedRegister, userData:userData);
   const LoginState.loading():this._(status:LoginStatus.Loading);
   const LoginState.success():this._(status:LoginStatus.LoginSuccess);
   const LoginState.wrongPassword():this._(status:LoginStatus.WrongPassword);
   const LoginState.failure():this._(status:LoginStatus.Failure);

  @override
  List<Object> get props =>[status];
}


