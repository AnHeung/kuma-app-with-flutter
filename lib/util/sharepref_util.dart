import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUserData({LoginUserData userData}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", userData.userId);
  prefs.setString("userName", userData.userName);
  prefs.setString("loginType", enumToString(userData.loginType));
  prefs.setString("rankType", userData.rankType);
  prefs.setBool("autoScroll", userData.isAutoScroll);
  prefs.setString("homeItemCount",userData.homeItemCount);
}

saveUserId({String userId}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id",userId);
}

appFirstLaunch() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("firstLaunch") ?? true;
}

saveAppFirstLaunch({bool isAppFirst = false}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("firstLaunch",isAppFirst);
}


saveAutoScroll({bool isAutoScroll = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("autoScroll", isAutoScroll);
}

saveHomeItemCount({String homeItemCount = "30"}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("homeItemCount", homeItemCount);
}

saveRankingType({String rankType = kBaseRankItem}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("rankType", rankType);
}

saveSettingConfig({SettingConfig settingConfig})async{
  await saveRankingType(rankType:settingConfig.rankType);
  await saveHomeItemCount(homeItemCount: settingConfig.homeItemCount);
  await saveAutoScroll(isAutoScroll: settingConfig.isAutoScroll);
}


Future<bool> removeUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("id");
  prefs.remove("userName");
  prefs.remove("loginType");
  prefs.remove("autoScroll");
  prefs.remove("homeItemCount");
  prefs.remove("rankingType");
  return true;
}

removeAllData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

getUserId() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("id");
}

getUserData()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return LoginUserData(userId:  prefs.getString("id") , homeItemCount:  prefs.getString("homeItemCount") ,  isAutoScroll: prefs.getBool("autoScroll"),rankType: prefs.getString("rankType"),
      loginType: enumFromString<LoginType>(prefs.getString("loginType"), LoginType.values), userName:  prefs.getString("userName"));
}

printUserData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('userId : ${prefs.getString("id")} , loginType: ${prefs.getString("loginType")} userName:${prefs.getString("userName")} isAutoScroll : ${prefs.getBool("autoScroll")}');
}
