import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';

class UserAccount {

  final String userId;
  final String userName;
  final LoginType loginType;

  const UserAccount({userId, userName, loginType}):this.userId = userId ?? "" , this.userName = userName ?? "" , this.loginType = loginType ?? LoginType.UNKNOWN;

}