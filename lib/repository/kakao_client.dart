import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/screen/home_screen.dart';

class KakaoClient extends SocialClient{

  final BuildContext context;

  KakaoClient({@required this.context}): assert(context != null){
    KakaoContext.clientId = "c2de908819754be96af4d46766eaa8eb";
    KakaoContext.javascriptClientId = "145316ccaf6edd8159668aee4133c4a5";
  }

  @override
  login() async{
    try {
      SocialUserData user;
      if(await isKakaoTalkInstalled()) user = await loginWithKakaoTalk();
      else user =  await loginWithKakao();
      return user;
    }on Exception {
      print("kakao Login error");
      return null;
    }
  }

  _issueAccessToken(String authCode) async{
    var token = await AuthApi.instance.issueAccessToken(authCode);
    AccessTokenStore.instance.toStore(token);
    SocialUserData kakaoUserInfo = await getKakaoAccountInfo();
    if(kakaoUserInfo!= null) return kakaoUserInfo;
  }

  loginWithKakao() async{
    try {
      String code = await AuthCodeClient.instance.request();
      return await _issueAccessToken(code);
    } catch (e) {
      print("loginWithKakao err : $e");
      return null;
    }
  }

  Future<SocialUserData> getKakaoAccountInfo()async{
    var user = await UserApi.instance.me();
    if(user.kakaoAccount!= null){
      if(user.kakaoAccount.email == null){
        await logout();
        return null;
      }else{
        print('email : ${user.kakaoAccount.email} unique Id :${user.id}');
        return SocialUserData(id: user.id.toString(), email: user.kakaoAccount.email);
      }
    }
  }

  loginWithKakaoTalk() async{
    try {
      String code = await AuthCodeClient.instance.requestWithTalk();
      return await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  @override
  logout() async{
    await UserApi.instance.unlink();
  }

}