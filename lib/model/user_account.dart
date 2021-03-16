import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';

class UserAccount {

  final String email;
  final String userName;
  final String loginType;
  final SocialType socialType;

  UserAccount({this.email, this.userName, this.loginType, this.socialType});


}