import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/model/setting_config.dart';
import 'package:kuma_flutter_app/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUserData({SocialUserData userData}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", userData.email);
  prefs.setString("pw", userData.uniqueId);
  prefs.setString("userName", userData.userName);
  prefs.setString("socialType", enumToString(userData.socialType));
}

changeAutoConfig({bool isAutoScroll = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("autoScroll", isAutoScroll);
}

changeAniLoadItemCount({String aniLoadItemCount = "30"}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("aniLoadItemCount", aniLoadItemCount);
}

changeRankingType({String rankingType ="all"}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("rankingType", rankingType);
}

getAutoScroll({bool isAutoScroll}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isAutoScroll = prefs.getBool("autoScroll") ?? true;
  return isAutoScroll;
}

getSettingConfig() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isAutoScroll = prefs.getBool("autoScroll") ?? true;
  String aniLoadCount = prefs.getString("aniLoadItemCount") ?? "30";
  String rankingType = prefs.getString("rankingType") ?? "all";
  return SettingConfig(isAutoScroll: isAutoScroll , aniLoadItemCount: aniLoadCount, rankingType:rankingType);
}

changeSettingConfig({SettingConfig config}) async{
  if(config!= null) {
    await changeAutoConfig(isAutoScroll: config.isAutoScroll);
    await changeAniLoadItemCount(aniLoadItemCount: config.aniLoadItemCount);
    await changeRankingType(rankingType: config.rankingType);
  }
}


removeUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

getUserData()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return SocialUserData(uniqueId:prefs.getString("pw"),email:prefs.getString("id") , socialType: enumFromString(prefs.getString("socialType"), SocialType.values));
}

printUserData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('userId : ${prefs.getString("id")}, userPw :${prefs.getString("pw")}, socialType: ${prefs.getString("socialType")} userName:${prefs.getString("userName")} isAutoScroll : ${prefs.getBool("autoScroll")}');
}
