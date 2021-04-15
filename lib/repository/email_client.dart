import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';
import 'package:kuma_flutter_app/util/sharepref_util.dart';

class EmailClient extends LoginClient{

  static final EmailClient _instance = EmailClient._();

  factory EmailClient ()=>_instance;

  EmailClient._();

  Future<LoginUserData> login({String id ,String pw}) async{
      LoginUserData data = await getUserData();
      String id = data.email;
      String pw = data.uniqueId;
      if(id == null || pw == null) return const LoginUserData(loginType: LoginType.EMAIL);
      return data;
  }

  logout() {
    print('email 로그아웃');
  }
}