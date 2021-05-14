import 'package:kakao_flutter_sdk/all.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/model/api/login_user.dart';
import 'package:kuma_flutter_app/repository/social_client.dart';

class KakaoClient extends LoginClient{

  static final KakaoClient _instance = KakaoClient._();

  factory KakaoClient()=> _instance;


  KakaoClient._(){
    KakaoContext.clientId = "c2de908819754be96af4d46766eaa8eb";
    KakaoContext.javascriptClientId = "145316ccaf6edd8159668aee4133c4a5";
  }

  @override
  login() async{
    try {
      LoginUserData user;
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
    LoginUserData kakaoUserInfo = await getKakaoAccountInfo();
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

  Future<LoginUserData> getKakaoAccountInfo()async{
    var user = await UserApi.instance.me();
    if(user.kakaoAccount!= null){
      if(user.kakaoAccount.email == null){
        await logout();
        return null;
      }else{
        print('email : ${user.kakaoAccount.email} unique Id :${user.id} userNick : ${user.kakaoAccount.profile.nickname}');
        return LoginUserData(uniqueId: user.id.toString(), userId: user.kakaoAccount.email ,userName: user.kakaoAccount.profile.nickname, loginType: LoginType.KAKAO);
      }
    }
    return null;
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
    try {
      await UserApi.instance?.unlink();
    }catch (e){
      print("카카오 로그아웃 실패 $e");
    }
  }

}