part of 'common.dart';

saveUserData({LoginUserData userData}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", userData.token);
  prefs.setString("id", userData.userId);
  prefs.setString("userName", userData.userName);
  prefs.setString("loginType", enumToString(userData.loginType));
  prefs.setBool("receiveNotify", userData.receiveNotify);
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

saveReceiveNotify({bool receiveNotify = true}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("receiveNotify", receiveNotify);
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
  await saveReceiveNotify(receiveNotify: settingConfig.receiveNotify);
}


Future<bool> removeUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
  prefs.remove("id");
  prefs.remove("userName");
  prefs.remove("loginType");
  prefs.remove("autoScroll");
  prefs.remove("receiveNotify");
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
  return LoginUserData(token:prefs.getString("token"), userId:  prefs.getString("id") , homeItemCount:  prefs.getString("homeItemCount") ,  isAutoScroll: prefs.getBool("autoScroll") , receiveNotify: prefs.getBool("receiveNotify"),rankType: prefs.getString("rankType"),
      loginType: enumFromString<LoginType>(prefs.getString("loginType"), LoginType.values), userName:  prefs.getString("userName"));
}

printUserData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log('token : ${prefs.getString("token")} , userId : ${prefs.getString("id")} , loginType: ${prefs.getString("loginType")} ,userName:${prefs.getString("userName")} '
      'isAutoScroll : ${prefs.getBool("autoScroll")} ,receiveNotify : ${prefs.getBool("receiveNotify")} , homeItemCount :${prefs.getString("homeItemCount")} ,rankType :${prefs.getString("rankType")}');
}
