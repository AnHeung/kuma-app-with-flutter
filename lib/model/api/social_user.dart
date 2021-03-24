import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';

class LoginUserData{

 final String uniqueId;
 final  String email;
 final String userName;
 final LoginType loginType;

 const LoginUserData({this.uniqueId , this.email, this.userName, this.loginType});

 static const empty = LoginUserData(email: '', uniqueId: '', userName: '', loginType:LoginType.UNKNOWN);

}