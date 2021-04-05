import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';

class GoogleClient extends LoginClient{

  static final GoogleClient _instance = GoogleClient._();
  GoogleSignIn signIn;

  factory GoogleClient () =>_instance;

  GoogleClient._(){
    signIn = GoogleSignIn();
  }

  @override
  Future<LoginUserData> login() async{
      await logout();
      GoogleSignInAccount account =   await signIn.signIn();
      if(account != null) return LoginUserData(email: account.email,  uniqueId: account.id , loginType: LoginType.GOOGLE, userName: account.displayName);
      return null;
  }

  @override
  logout() async{
    try {
      await signIn?.signOut();
    }catch(e){
      print("구글 로그아웃 실패$e");
    }
  }
}