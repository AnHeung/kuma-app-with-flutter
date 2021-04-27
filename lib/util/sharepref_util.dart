import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUserData({LoginUserData userData}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", userData.email);
  prefs.setString("pw", userData.uniqueId);
  prefs.setString("userName", userData.userName);
  prefs.setString("loginType", enumToString(userData.loginType));
}

appFirstLaunch() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("firstLaunch") ?? true;
}

saveAppFirstLaunch({bool isAppFirst = false}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("firstLaunch",isAppFirst);
}


changeAutoConfig({bool isAutoScroll = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("autoScroll", isAutoScroll);
}

changeAniLoadItemCount({String aniLoadItemCount = "30"}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("aniLoadItemCount", aniLoadItemCount);
}

changeRankingType({String rankingType = kBaseRankItem}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("rankingType", rankingType);
}

Future<SettingConfig> getSettingConfig() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isAutoScroll = prefs.getBool("autoScroll") ?? true;
  String aniLoadCount = prefs.getString("aniLoadItemCount") ?? "30";
  String rankingType = prefs.getString("rankingType") ?? "airing,upcoming,movie";
  return SettingConfig(isAutoScroll: isAutoScroll , aniLoadItemCount: aniLoadCount, rankingType:rankingType);
}

changeSettingConfig({SettingConfig config}) async {
  if(config!= null) {
    await changeAutoConfig(isAutoScroll: config.isAutoScroll);
    await changeAniLoadItemCount(aniLoadItemCount: config.aniLoadItemCount);
    await changeRankingType(rankingType: config.rankingType);
  }
}


removeUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("id");
  prefs.remove("pw");
  prefs.remove("userName");
  prefs.remove("loginType");
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
  return LoginUserData(uniqueId:prefs.getString("pw"),email:prefs.getString("id") , loginType: enumFromString(prefs.getString("loginType"), LoginType.values));
}

printUserData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('userId : ${prefs.getString("id")}, userPw :${prefs.getString("pw")}, loginType: ${prefs.getString("loginType")} userName:${prefs.getString("userName")} isAutoScroll : ${prefs.getBool("autoScroll")}');
}
