import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/util/common.dart';

class LoginUserData{

 final String token;
 final String userId;
 final String uniqueId;
 final String userName;
 final LoginType loginType;
 final bool isAutoScroll;
 final bool receiveNotify;
 final String homeItemCount;
 final String rankType;

 const LoginUserData({this.token ,this.uniqueId, this.userId , this.userName, this.loginType, this.isAutoScroll, this.receiveNotify,this.homeItemCount,this.rankType});

 static const empty = LoginUserData(token : '', uniqueId: '',userId: '', userName: '',  loginType:LoginType.UNKNOWN ,isAutoScroll:true, receiveNotify:false, homeItemCount:kBaseHomeItemCount , rankType: kBaseRankItem);

 LoginUserData copyWith({String token , String userId, bool isAutoScroll, String uniqueId , String homeItemCount, String rankType ,String userName, String loginType, bool receiveNotify}){
  return LoginUserData(token:token ?? this.token , loginType: loginType?? this.loginType , userId: userId ?? this.userId, homeItemCount: homeItemCount ?? this.homeItemCount,
      rankType: rankType ?? this.rankType , isAutoScroll: isAutoScroll ?? this.isAutoScroll , receiveNotify: receiveNotify ?? this.receiveNotify,userName: userName?? this.userName, uniqueId: uniqueId ?? this.uniqueId);
 }

 factory LoginUserData.fromMap(Map<String, dynamic> map) {
    return new LoginUserData(
      token: map['token'] as String,
      userId: map['userId'] as String,
      uniqueId: map['uniqueId'] as String,
      userName: map['userName'] as String,
      loginType: enumFromString<LoginType>(map['loginType'], LoginType.values),
      isAutoScroll: map['isAutoScroll'] as bool,
      receiveNotify: map['receiveNotify'] as bool,
      homeItemCount: map['homeItemCount'] as String,
      rankType: map['rankType'] as String,
    );
  }

 Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'userId': this.userId,
      'uniqueId': this.uniqueId,
      'userName': this.userName,
      'loginType': enumToString(this.loginType),
      'isAutoScroll': this.isAutoScroll,
      'receiveNotify': this.receiveNotify,
      'homeItemCount': this.homeItemCount,
      'rankType': this.rankType,
    };
  }
}