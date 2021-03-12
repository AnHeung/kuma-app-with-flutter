import 'package:shared_preferences/shared_preferences.dart';

isLogin()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isLogin");
}