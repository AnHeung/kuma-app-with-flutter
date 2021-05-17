import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/util/string_util.dart';

class LoginUserData{

 final String userId;
 final String uniqueId;
 final String userName;
 final LoginType loginType;
 final bool isAutoScroll;
 final bool receiveNotify;
 final String homeItemCount;
 final String rankType;

 const LoginUserData({this.uniqueId, this.userId , this.userName, this.loginType, this.isAutoScroll, this.receiveNotify,this.homeItemCount,this.rankType});

 static const empty = LoginUserData(uniqueId: '',userId: '', userName: '',  loginType:LoginType.UNKNOWN ,isAutoScroll:true, receiveNotify:false, homeItemCount:kBaseHomeItemCount , rankType: kBaseRankItem);

 LoginUserData copyWith({String userId, bool isAutoScroll, String uniqueId , String homeItemCount, String rankType ,String userName, String loginType}){
  return LoginUserData(loginType: loginType?? this.loginType , userId: userId ?? this.userId, homeItemCount: homeItemCount ?? this.homeItemCount,
      rankType: rankType ?? this.rankType , isAutoScroll: isAutoScroll ?? this.isAutoScroll , receiveNotify: receiveNotify ?? this.receiveNotify,userName: userName?? this.userName, uniqueId: uniqueId ?? this.uniqueId);
 }

 factory LoginUserData.fromMap(Map<String, dynamic> map) {
    return new LoginUserData(
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