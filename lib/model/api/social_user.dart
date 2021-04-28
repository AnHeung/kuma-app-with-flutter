import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/util/string_util.dart';

class LoginUserData{

 final String userId;
 final String uniqueId;
 final String userName;
 final LoginType loginType;
 final bool isAutoScroll;
 final String homeItemCount;
 final String rankType;

 const LoginUserData({this.uniqueId, this.userId , this.userName, this.loginType, this.isAutoScroll, this.homeItemCount,this.rankType});

 static const empty = LoginUserData(uniqueId: '',userId: '', userName: '',  loginType:LoginType.UNKNOWN ,isAutoScroll:true, homeItemCount:kBaseHomeItemCount , rankType: kBaseRankItem);

 LoginUserData copyWith({String userId, bool isAutoScroll, String homeItemCount, String rankType ,String userName, String loginType}){
  return LoginUserData(loginType: loginType?? this.loginType , userId: userId ?? this.userId, homeItemCount: homeItemCount ?? this.homeItemCount,
      rankType: rankType ?? this.rankType , isAutoScroll: isAutoScroll ?? this.isAutoScroll ,userName: userName?? this.userName, uniqueId: uniqueId ?? this.uniqueId);
 }

 factory LoginUserData.fromMap(Map<String, dynamic> map) {
    return LoginUserData(
      userId: map['userId'] as String,
      uniqueId: map['uniqueId'] as String,
      userName: map['userName'] as String,
      loginType: enumFromString<LoginType>(map['loginType'], LoginType.values),
      isAutoScroll: map['isAutoScroll'] as bool,
      homeItemCount: map['homeItemCount'] as String,
      rankType: map['rankType'] as String,
    );
  }
}