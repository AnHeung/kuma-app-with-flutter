import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUserData({SocialUserData userData}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", userData.email);
  prefs.setString("pw", userData.uniqueId);
  prefs.setString("socialType", userData.socialType.toString());
}

removeUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

getUserData()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return SocialUserData(uniqueId:prefs.getString("pw"),email:prefs.getString("id") ,  socialType:SocialType.KAKAO);
}

printUserData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('userId : ${prefs.getString("id")}, userPw :${prefs.getString("pw")}, socialType: ${prefs.getString("socialType")}');
}
